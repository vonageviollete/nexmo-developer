---
title: Check report status
---

# Check report status

Once a report has been requested, it may take some time to generate the content. You can check on the progress of your report by calling the `GET /v2/reports/:id` endpoint e.g.

```bash
curl -u $API_KEY:$API_SECRET https://api.nexmo.com/v2/reports/6c5506b7-f16a-44dc-af06-756bbf467488
```

> In addition to polling for the report's status, you can sign up to be notified via a webhook when the report generation is complete. To do this, you must specify a `callback_url` parameter when creating the report.

The response returned will contain information about the report. The `url` field in particular is important as this is where you'll download your report from

```json
{
  "request_id": "6c5506b7-f16a-44dc-af06-756bbf467488",
  "request_status": "SUCCESS",
  "product": "SMS",
  "account_id": "$API_KEY",
  "start_date": "2019-02-27T00:00:00+0000",
  "end_date": "2019-02-28T23:59:59+0000",
  "include_subaccounts": false,
  "direction": "outbound",
  "include_message": false,
  "file_id": "bd805ad6-756f-46a1-9c29-c58bc68bc77f",
  "url": "https://api.nexmo.com/v3/media/bd805ad6-756f-46a1-9c29-c58bc68bc77f",
  "receive_time": "2019-06-17T16:39:06+0000",
  "start_time": "2019-06-17T16:39:06+0000",
  "_links": {
    "self": {
      "href": "/v2/reports/6c5506b7-f16a-44dc-af06-756bbf467488"
    }
  },
  "items_count": 14952,
  "self_link": "https://api.nexmo.com/v2/reports//6c5506b7-f16a-44dc-af06-756bbf467488"
}
```

