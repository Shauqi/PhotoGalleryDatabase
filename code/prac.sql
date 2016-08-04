set serveroutput on;
create or replace function get_annual_comp(sal employees.salary%type,comm employees.commission_pct%type) return number is
begin
return (NVL(sal,0)*12+(NVL(comm,0)*NVL(sal,0)*12));
end get_annual_comp;
/	