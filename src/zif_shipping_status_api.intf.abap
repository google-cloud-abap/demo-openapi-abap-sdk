INTERFACE zif_shipping_status_api
  PUBLIC .


  TYPES:
    "! <p class="shorttext synchronized" lang="en">getShippingStatus_400_response</p>
    BEGIN OF ty_005,
      error TYPE string, "Error message indicating the missing tracking_id.
    END OF ty_005.

  TYPES:
    "! <p class="shorttext synchronized" lang="en">ShippingEvents</p>
    BEGIN OF ty_002,
      timestamp TYPE string, "Timestamp of the event.
      event     TYPE string, "Description of the event.
    END OF ty_002.
  TYPES:
    "! <p class="shorttext synchronized" lang="en">ShippingStatusRequest</p>
    BEGIN OF ty_000,
      tracking_id TYPE string, "The unique identifier for the shipment.
      carrier     TYPE string, "The name of the shipping carrier (e.g., FedEx, UPS, DHL).
    END OF ty_000.

  TYPES:
    "! <p class="shorttext synchronized" lang="en">ShippingStatusResponse</p>
    BEGIN OF ty_003,
      tracking_id             TYPE string, "The unique identifier for the shipment.
      status                  TYPE string, "Current status of the shipment (e.g.
      estimated_delivery_date TYPE string, "Estimated date of delivery.
      location                TYPE string, "Current location of the shipment.
      events                  TYPE STANDARD TABLE OF ty_002 WITH NON-UNIQUE DEFAULT KEY,
    END OF ty_003.
ENDINTERFACE.
