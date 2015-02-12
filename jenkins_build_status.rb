JENKINS_URI = "http://localhost:8080/"

JENKINS_AUTH = {
  'name' => null,
  'password' => null
}

SCHEDULER.every '10s' do

  json = getFromJenkins("api/json?pretty=true")

  failedJobs = Array.new
  succeededJobs = Array.new
  array = json["jobs"]
  array.each {
    |job|
    next if job["color"] == "disabled"
    next if job["color"] == "notbuilt"

    if job["color"] != "blue" && job["color"] != "blue_anime"

      jobStatus = getFromJenkins("job/" + job["name"] + "/lastFailedBuild/api/json")
      culprits = jobStatus["culprits"]

      culpritName = getNameFromCulprits(culprits)
      if culpritName != ""
      	 culpritName = culpritName.partition('<').first
      end

      failedJobs.push({ label: job["name"], value: culpritName})
    end
  }

  failed = failedJobs.size > 0

  send_event('jenkinsBuildStatus', { failedJobs: failedJobs, succeededJobs: succeededJobs, failed: failed })
end

def getFromJenkins(path)

  uri = URI.parse(JENKINS_URI + path)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  if JENKINS_AUTH['name']
    request.basic_auth(JENKINS_AUTH['name'], JENKINS_AUTH['password'])
  end
  response = http.request(request)

  json = JSON.parse(response.body)
  return json
end

def getNameFromCulprits(culprits)
  culprits.each {
    |culprit|
    return culprit["fullName"]
  }
  return ""
end
