*&---------------------------------------------------------------------*
*& Report ZMB_ALV_REPORT_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmb_alv_report_2.


"Interactive alv report

TYPE-POOLS: slis .



TYPES: BEGIN OF st_mara ,
         matnr TYPE matnr,
         mtart TYPE mtart,
         ersda TYPE ersda,
         ntgew TYPE ntgew,
       END OF st_mara .
DATA: it_mara        TYPE TABLE OF st_mara,
      wa_mara        TYPE st_mara,
      it_design_alv  TYPE slis_t_fieldcat_alv,
      wa_design_alv  TYPE slis_fieldcat_alv,
      it_sort_fields TYPE slis_t_sortinfo_alv,
      wa_sort_fields TYPE slis_sortinfo_alv,
      wa_layout_alv  TYPE slis_layout_alv.



SELECT matnr
       mtart
       ersda
       ntgew
  FROM mara INTO TABLE it_mara UP TO 20 ROWS .

PERFORM build_fieldcat USING '1' '1' 'matnr' 'material Number' '8'.
PERFORM build_fieldcat USING '1' '2' 'mtart' 'material Type' '8'.
PERFORM build_fieldcat USING '1' '3' 'ersda' 'Created On' '8'.
PERFORM build_fieldcat USING '1' '4' 'ntgew' 'Weigth Net' '8'.

wa_layout_alv-zebra = 'X' .


wa_sort_fields-fieldname = 'matnr' .
wa_sort_fields-up = 'X' .

APPEND wa_sort_fields TO it_sort_fields .
CLEAR wa_sort_fields .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program      = sy-repid
    i_callback_user_command = 'MARD_DETAILS'
    i_structure_name        = 'st_mara'
    is_layout               = wa_layout_alv
    it_fieldcat             = it_design_alv
    it_sort                 = it_sort_fields
  TABLES
    t_outtab                = it_mara.

CLEAR wa_layout_alv .
FORM build_fieldcat USING
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
  APPEND wa_design_alv TO it_design_alv .

ENDFORM .

FORM MARD_DETAILS USING
                         p_ucomm TYPE sy-ucomm
                         p_selfdetails TYPE slis_selfield ."selection field detail
  DATA:
          it_mard TYPE STANDARD TABLE OF mard .
  SELECT *
         FROM mard INTO  TABLE it_mard WHERE matnr = p_selfdetails-value .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_structure_name = 'MARD'
*     I_BACKGROUND_ID  = ' '
*     I_GRID_TITLE     =
*     I_GRID_SETTINGS  =
*     IS_LAYOUT        =
*     IT_FIELDCAT      =
*     IT_EXCLUDING     =
*     IT_SPECIAL_GROUPS                 =
*     IT_SORT          =
*     IT_FILTER        =
*     IS_SEL_HIDE      =
*     I_DEFAULT        = 'X'
*     I_SAVE           = ' '
*     IS_VARIANT       =
*     IT_EVENTS        =
*     IT_EVENT_EXIT    =
*     IS_PRINT         =
*     IS_REPREP_ID     =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS  =
*     IT_HYPERLINK     =
*     IT_ADD_FIELDCAT  =
*     IT_EXCEPT_QINFO  =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER           =
*      IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab         = it_mard
*      EXCEPTIONS
*     PROGRAM_ERROR    = 1
*     OTHERS           = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM .
