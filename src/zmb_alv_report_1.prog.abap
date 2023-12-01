*&---------------------------------------------------------------------*
*& Report ZMB_ALV_REPORT_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmb_alv_report_1.





" DECLARING THE STRUCTURE OF MARA TABLE .
TYPE-POOLS: slis .

TYPES: BEGIN OF st_mara ,
         matnr TYPE matnr,
         mtart TYPE mtart,
         ersda TYPE ersda,
         ntgew TYPE ntgew,
       END OF st_mara .
DATA: it_mara       TYPE TABLE OF st_mara,
      wa_mara       TYPE st_mara,
      it_design_alv TYPE slis_t_fieldcat_alv,
      wa_design_alv TYPE slis_fieldcat_alv.



SELECT matnr
       mtart
       ersda
       ntgew
  FROM mara INTO TABLE it_mara .


wa_design_alv-col_pos = 1 .
wa_design_alv-fieldname = 'matnr' .
wa_design_alv-seltext_m = 'MATERIAL NUMBER ' .

APPEND wa_design_alv TO it_design_alv .

CLEAR wa_design_alv .


wa_design_alv-col_pos = 2 .
wa_design_alv-fieldname = 'mtart' .

wa_design_alv-seltext_m = 'MATERIAL Type ' .

APPEND wa_design_alv TO it_design_alv .

CLEAR wa_design_alv .

wa_design_alv-col_pos = 3 .
wa_design_alv-fieldname = 'ersda' .

wa_design_alv-seltext_m = 'Created On  ' .

APPEND wa_design_alv TO it_design_alv .

CLEAR wa_design_alv .


wa_design_alv-col_pos = 4 .
wa_design_alv-fieldname = 'ntweg' .

wa_design_alv-seltext_m = 'Net Weight  ' .

APPEND wa_design_alv TO it_design_alv .

CLEAR wa_design_alv .




CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK  = ' '
*   I_BYPASSING_BUFFER = ' '
*   I_BUFFER_ACTIVE    = ' '
    i_callback_program = 'sy-repid'
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
    i_structure_name   = 'st_mara'
*   I_BACKGROUND_ID    = ' '
*   I_GRID_TITLE       =
*   I_GRID_SETTINGS    =
*   IS_LAYOUT          =
    it_fieldcat        = it_design_alv
*   IT_EXCLUDING       =
*   IT_SPECIAL_GROUPS  =
*   IT_SORT            =
*   IT_FILTER          =
*   IS_SEL_HIDE        =
*   I_DEFAULT          = 'X'
*   I_SAVE             = ' '
*   IS_VARIANT         =
*   IT_EVENTS          =
*   IT_EVENT_EXIT      =
*   IS_PRINT           =
*   IS_REPREP_ID       =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE  = 0
*   I_HTML_HEIGHT_TOP  = 0
*   I_HTML_HEIGHT_END  = 0
*   IT_ALV_GRAPHICS    =
*   IT_HYPERLINK       =
*   IT_ADD_FIELDCAT    =
*   IT_EXCEPT_QINFO    =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab           = it_mara
* EXCEPTIONS
*   PROGRAM_ERROR      = 1
*   OTHERS             = 2
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
