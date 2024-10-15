import functions_framework
from flask import jsonify, request

@functions_framework.http
def shipping_status(request):
  """ HTTP Cloud Function to retrieve shipping status. """

  request_json = request.get_json(silent=True) 

  if request_json and 'trackingId' in request_json:
    tracking_id = request_json['trackingId']
    carrier = request_json.get('carrier')  # Optional parameter

    # TODO: Implement logic to fetch shipping status from your data store
    # based on tracking_id and carrier (if provided).
    # This might involve querying a database, calling a third-party API, etc.
    
    # Example placeholder data (replace with your actual data retrieval logic)
    status = "In transit"
    estimated_delivery_date = "2024-10-25"
    location = "Bengaluru, India"
    events = [
        { "timestamp": "2024-10-20 10:00:00", "event": "Picked up" },
        { "timestamp": "2024-10-22 14:30:00", "event": "Arrived at sorting facility" },
        { "timestamp": "2024-10-24 09:15:00", "event": "Departed sorting facility" }
    ]

    response = {
        "tracking_id": tracking_id,
        "status": status,
        "estimated_delivery_date": estimated_delivery_date,
        "location": location,
        "events": events
    }
    return jsonify(response)
  else:
    return jsonify({'error': 'Missing Tracking ID'}), 400