*&---------------------------------------------------------------------*
*& Report ZMB_ALV_REPORT_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMB_ALV_REPORT_2.


"Interactive alv report

TYPE-POOLS: SLIS .



TYPES: BEGIN OF st_mara ,
         matnr TYPE matnr,
         mtart TYPE mtart,
         ersda TYPE ersda,
         ntgew TYPE ntgew,
       END OF st_mara .
DATA: it_mara       TYPE TABLE OF st_mara,
      wa_mara       TYPE st_mara,
      it_design_alv TYPE slis_t_fieldcat_alv,
      wa_design_alv TYPE slis_fieldcat_alv ,
      wa_layout_alv type slis_layout_alv .



SELECT matnr
       mtart
       ersda
       ntgew
  FROM mara INTO TABLE it_mara .

PERFORM build_fieldcat USING '1' '1' 'matnr' 'material Number' '8'.
PERFORM build_fieldcat USING '1' '2' 'mtart' 'material Type' '8'.
PERFORM build_fieldcat USING '1' '3' 'ersda' 'Created On' '8'.
PERFORM build_fieldcat USING '1' '4' 'ntgew' 'Weigth Net' '8'.

wa_layout_alv-zebra = 'X' .

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
   I_CALLBACK_PROGRAM                = 'sy-repid'
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
   I_STRUCTURE_NAME                  =  'st_mara'
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
     IS_LAYOUT                         = wa_layout_alv
   IT_FIELDCAT                       = it_design_alv
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab                          = it_mara
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
CLEAR wa_layout_alv .
FORM build_fieldcat using
                            VALUE(p_rowpos)
                            VALUE(p_colpos)
                            VALUE(p_fieldname)
                            VALUE(p_header_text)
                            VALUE(p_length) .
  wa_design_alv-row_pos = p_rowpos .
  wa_design_alv-col_pos = p_colpos .
  wa_design_alv-fieldname = p_fieldname .
  wa_design_alv-seltext_m = p_header_text .
  wa_design_alv-outputlen = p_length .
  append wa_design_alv to it_design_alv .

ENDFORM .
