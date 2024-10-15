*&---------------------------------------------------------------------*
*& Report ZTEST_SHIPPING_STATUS_API
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_shipping_status_api.

TRY.
    " Initialize a client for the API stub generated by OpenAPI Generator
    DATA(lo_client) = NEW zcl_shipping_status_api( iv_key_name = 'DEMO_SHIPPING' ).

    " Call method GET_SHIPPING_STATUS
    lo_client->get_shipping_status(
      EXPORTING
        is_input    = VALUE #( tracking_id = '1234567890' carrier = 'FedEx' )
      IMPORTING
        es_output   = DATA(ls_output)
        ev_ret_code = DATA(lv_ret_code)
        ev_err_text = DATA(lv_err_text)
        es_err_resp = DATA(ls_err_resp)
    ).

    IF lo_client->is_success( iv_code = lv_ret_code ).
      " In case of successful execution, display the response structure.
      cl_demo_output=>display( ls_output ).
    ELSE.
      " Handle Error
      MESSAGE lv_err_text TYPE 'E'.
    ENDIF.
  CATCH /goog/cx_sdk INTO DATA(lo_exception).
    " Handle Exception
    DATA(lv_msg) = lo_exception->get_text( ).
    MESSAGE lv_msg TYPE 'E'.
ENDTRY.