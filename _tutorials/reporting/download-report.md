---
title: Download a report
---

# Download a report

Once the report has been generated, you can download the results using the Media API.


```bash
curl -u $API_KEY:$API_SECRET -o ./report.zip https://api.nexmo.com/v3/media/<id>
```

The ID you need to download the report is returned in the `file_id` field of the report status response. Alternatively, you can fetch the file using the entire URL in the `url` field.

Running the above command will download the report in to the current folder as a file named `report.zip`. Unzip this to see the results of your report

