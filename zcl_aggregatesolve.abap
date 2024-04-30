CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.
CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
   

  aggregated_data = VALUE #( ).
  DATA(suma) = 0.
  DATA(sumb) = 0.
  DATA(sumc) = 0.
  DATA(sumd) = 0.
  DATA(sume) = 0.
  DATA(sumf) = 0.
  DATA(mina) = 999.
  DATA(minb) = 999.
  DATA(minc) = 999.
  DATA(mind) = 999.
  DATA(mine) = 999.
  DATA(minf) = 999.
  DATA(maxa) = 0.
  DATA(maxb) = 0.
  DATA(maxc) = 0.
  DATA(maxd) = 0.
  DATA(maxe) = 0.
  DATA(maxf) = 0.
  DATA(counta) = 0.
  DATA(countb) = 0.
  DATA(countc) = 0.
  DATA(countd) = 0.
  DATA(counte) = 0.
  DATA(countf) = 0.
  DATA(idx) = lines( initial_numbers ).
  WHILE idx > 0.
  READ TABLE initial_numbers INDEX idx ASSIGNING FIELD-SYMBOL(<fs>).
  IF <fs>-group = 'A'.
  suma += <fs>-number.
  counta += 1.
  IF <fs>-number < mina.
  mina = <fs>-number.
  ENDIF.
  IF <fs>-number > maxa.
  maxa = <fs>-number.
  ENDIF.
  
  ENDIF.

  IF <fs>-group = 'B'.
  sumb += <fs>-number.
  countb += 1.
  IF <fs>-number < minb.
  minb = <fs>-number.
  ENDIF.
  IF <fs>-number > maxb.
  maxb = <fs>-number.
  ENDIF.
  
  ENDIF.

  IF <fs>-group = 'C'.
  sumc += <fs>-number.
  countc += 1.
  IF <fs>-number < minc.
  minc = <fs>-number.
  ENDIF.
  IF <fs>-number > maxc.
  maxc = <fs>-number.
  ENDIF.
  
  ENDIF.

  IF <fs>-group = 'D'.
  sumd += <fs>-number.
  countd += 1.
  IF <fs>-number < mind.
  mind = <fs>-number.
  ENDIF.
  IF <fs>-number > maxd.
  maxd = <fs>-number.
  ENDIF.

ENDIF.

  IF <fs>-group = 'E'.
  sume += <fs>-number.
  counte += 1.
  IF <fs>-number < mine.
  mine = <fs>-number.
  ENDIF.
  IF <fs>-number > maxe.
  maxe = <fs>-number.
  ENDIF.

ENDIF.

  IF <fs>-group = 'F'.
  sumf += <fs>-number.
  countf += 1.
  IF <fs>-number < minf.
  minf = <fs>-number.
  ENDIF.
  IF <fs>-number > maxf.
  maxf = <fs>-number.
  ENDIF.

ENDIF.

  idx -= 1.
  ENDWHILE.

  IF counta > 0.
  APPEND VALUE #( group = 'A' count = counta sum = suma min = mina max = maxa average = suma / counta) TO aggregated_data.
  ENDIF.

  IF countb > 0.
  APPEND VALUE #( group = 'B' count = countb sum = sumb min = minb max = maxb average = sumb / countb) TO aggregated_data.
  ENDIF.

  IF countc > 0.
  APPEND VALUE #( group = 'C' count = countc sum = sumc min = minc max = maxc average = sumc / countc) TO aggregated_data.
  ENDIF.

 IF countd > 0.
  APPEND VALUE #( group = 'D' count = countd sum = sumd min = mind max = maxd average = sumd / countd) TO aggregated_data.
ENDIF.

IF counte > 0.
  APPEND VALUE #( group = 'E' count = counte sum = sume min = mine max = maxe average = sume / counte) TO aggregated_data.
ENDIF.

IF countf > 0.
  APPEND VALUE #( group = 'F' count = countf sum = sumf min = minf max = maxf average = sumf / countf) TO aggregated_data.
  ENDIF. 



 



        

    
                    

        

      

    
  ENDMETHOD.

ENDCLASS.
