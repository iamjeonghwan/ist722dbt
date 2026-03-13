
  
    

create or replace transient table Analytics.dbt_iamjeonghwan.my_second_dbt_model
    
    
    
    as (-- Use the `ref` function to select from other models

select *
from Analytics.dbt_iamjeonghwan.my_first_dbt_model
where id = 1
    )
;


  