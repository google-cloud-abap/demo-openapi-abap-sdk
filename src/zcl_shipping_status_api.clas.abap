CLASS zcl_shipping_status_api DEFINITION
   PUBLIC
  INHERITING FROM /goog/cl_http_client
  CREATE PUBLIC.
  PUBLIC SECTION.
    CONSTANTS c_service_name TYPE /goog/service_name VALUE 'DefaultApi'.
    CONSTANTS c_version TYPE string VALUE 'v1'.
    CONSTANTS c_root_url TYPE string VALUE 'https://demo--shipping-status-gateway-<Generated Hash>.uc.gateway.dev'.
    CONSTANTS c_path_prefix TYPE string VALUE ''.
    INTERFACES zif_shipping_status_api.
    TYPES: ty_t_string TYPE STANDARD TABLE OF string.

    METHODS get_shipping_status
      IMPORTING
        !is_input    TYPE zif_shipping_status_api~ty_000 OPTIONAL
      EXPORTING
        !es_raw      TYPE data
        !es_output   TYPE zif_shipping_status_api~ty_003
        !ev_ret_code TYPE i
        !ev_err_text TYPE string
        !es_err_resp TYPE /goog/err_resp
      RAISING
        /goog/cx_sdk .
    METHODS constructor
      IMPORTING
        !iv_key_name   TYPE /goog/keyname OPTIONAL
        !iv_log_obj    TYPE balobj_d OPTIONAL
        !iv_log_subobj TYPE balsubobj OPTIONAL
      RAISING
        /goog/cx_sdk .
    METHODS close.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_SHIPPING_STATUS_API IMPLEMENTATION.


  METHOD close.
    me->close_http_client( ).
    CLEAR go_http.
  ENDMETHOD.


  METHOD constructor.

    DATA: lv_endpoint        TYPE string,
          lv_endpoint_suffix TYPE string.

    lv_endpoint = c_root_url.
    lv_endpoint_suffix = c_path_prefix.

    super->constructor( iv_key             = iv_key_name
                        iv_endpoint        = lv_endpoint
                        iv_endpoint_suffix = lv_endpoint_suffix
                        iv_service_name    = c_service_name
                        iv_log_obj         = iv_log_obj
                        iv_log_subobj      = iv_log_subobj ).

    gv_useragent_suffix = '/Solution:OpenAPI-ClientExe-1.0'.

  ENDMETHOD.


  METHOD get_shipping_status.
**************************************************************************
*& ID: org.openapitools.api.Default
**************************************************************************
    DATA: lv_uri        TYPE string,
          lv_json_final TYPE string,
          lv_mid        TYPE string,
          ls_output     LIKE es_output,
          lv_response   TYPE string.



    DATA: ls_common_qparam TYPE /goog/s_http_keys.

    lv_uri = gv_endpoint_suffix && |/shipping_status|.
    IF gt_common_qparams IS NOT INITIAL.
      lv_uri = lv_uri && '?'.
      LOOP AT gt_common_qparams INTO ls_common_qparam.
        IF ls_common_qparam-name IS NOT INITIAL AND
          ls_common_qparam-value IS NOT INITIAL.
          lv_uri = lv_uri && ls_common_qparam-name && '=' && ls_common_qparam-value.
          lv_uri = lv_uri && '&'.
        ENDIF.
      ENDLOOP.
      lv_uri = substring( val = lv_uri off = 0 len = strlen( lv_uri ) - 1 ).
    ENDIF.




    CONCATENATE c_service_name
                '#'
                'org.openapitools.api.Defaultget_shipping_status'
                INTO lv_mid.

    IF is_input IS SUPPLIED.
      lv_json_final = /goog/cl_json_util=>serialize_json(
        is_data          = is_input
        iv_method_id     = lv_mid
        it_name_mappings = gt_name_mappings
      ).
    ENDIF.
    " Call HTTP method
    CALL METHOD make_request
      EXPORTING
        iv_uri      = lv_uri
        iv_body     = lv_json_final
        iv_method   = c_method_post
      IMPORTING
        es_response = lv_response
        ev_ret_code = ev_ret_code
        ev_err_text = ev_err_text
        ev_err_resp = es_err_resp.

    es_raw = lv_response.

    IF es_output IS SUPPLIED.
      /goog/cl_json_util=>deserialize_json( EXPORTING iv_json          = lv_response
                                                      iv_pretty_name   = /ui2/cl_json=>pretty_mode-extended
                                                      iv_method_id     = lv_mid
                                                      it_name_mappings = gt_name_mappings
                                            IMPORTING es_data          = ls_output ).
      es_output = ls_output .
    ENDIF.
  ENDMETHOD.
ENDCLASS.
