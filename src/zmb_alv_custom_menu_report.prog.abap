*&---------------------------------------------------------------------*
*& Report ZMB_ALV_CUSTOM_MENU_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmb_alv_custom_menu_report.


TYPE-POOLS: slis .



TYPES: BEGIN OF st_mara ,
         matnr TYPE matnr,
         mtart TYPE mtart,
         ersda TYPE ersda,
         ntgew TYPE ntgew,
         cbox type char1 ,
       END OF st_mara .
DATA: it_mara        TYPE TABLE OF st_mara,
      wa_mara        TYPE st_mara,
      it_design_alv  TYPE slis_t_fieldcat_alv, "this structre is how to postionate and set cutome fieldname
      wa_design_alv  TYPE slis_fieldcat_alv,
      it_sort_fields TYPE slis_t_sortinfo_alv, "this for sorting the column
      wa_sort_fields TYPE slis_sortinfo_alv,
      wa_layout_alv  TYPE slis_layout_alv. "this to define withc theme you want to apply
DATA: wa_execlude TYPE LINE OF slis_t_extab,
      it_execlude TYPE slis_t_extab.
SELECT matnr
       mtart
       ersda
       ntgew
  FROM mara INTO TABLE it_mara UP TO 18 ROWS .

PERFORM build_fieldcat USING '1' '1' 'matnr' 'material Number' '15'.
PERFORM build_fieldcat USING '1' '2' 'mtart' 'material Type' '15'.
PERFORM build_fieldcat USING '1' '3' 'ersda' 'Created On' '15'.
PERFORM build_fieldcat USING '1' '4' 'ntgew' 'Weigth Net' '15'.



"execlude some toolbar function code from the alv report .

wa_execlude-fcode = '&OUP' .

APPEND wa_execlude to it_execlude .
clear wa_execlude .

wa_execlude-fcode = '&ODN' .

APPEND wa_execlude to it_execlude .
clear wa_execlude .






wa_layout_alv-box_fieldname = 'CBOX' .




wa_sort_fields-fieldname = 'matnr' .
wa_sort_fields-up = 'X' .

APPEND wa_sort_fields TO it_sort_fields .
CLEAR wa_sort_fields .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program       = sy-repid
    i_callback_pf_status_set = 'CUST_MENU'
    i_callback_user_command  = 'MARD_DETAILS'
    i_structure_name         = 'st_mara'
    is_layout                = wa_layout_alv
    it_fieldcat              = it_design_alv
    it_sort                  = it_sort_fields
   it_excluding             = it_execlude
  TABLES
    t_outtab                 = it_mara.




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



FORM mard_details USING
                         p_ucomm TYPE sy-ucomm
                         p_selfdetails TYPE slis_selfield ."selection field detail


LOOP AT it_mara ASSIGNING FIELD-SYMBOL(<fs_materialtype>) WHERE cbox is NOT INITIAL.
    <fs_materialtype>-mtart = 'MAT' .

ENDLOOP .

p_selfdetails-refresh = 'X' .
ENDFORM .




FORM CUST_MENU USING it_fcode TYPE slis_t_extab .

  SET PF-STATUS 'CMENU'  .

ENDFORM .
