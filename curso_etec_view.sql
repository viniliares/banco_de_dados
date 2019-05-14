use curso_etec;
go

create view prof_vlhora
as select curso.id_cur, nm_prof, vl_hora_prof
from curso inner join professor on curso.id_cur = professor.id_cur
where curso.id_cur = 1

select id_cur as 'curso', nm_prof as 'Nome Professor', vl_hora_prof as 'Salário hora'   
from prof_vlhora;

drop view prof_vlhora
/* a */
select * from professor
where vl_hora_prof > ( select avg(vl_hora_prof) 
						from professor )
order by vl_hora_prof desc

/* b */
select * from professor
where vl_hora_prof <= ( select avg(vl_hora_prof) 
						from professor )
order by vl_hora_prof

/* c */
select * from aluno
where dt_nas_alu > (select dt_nas_alu
					from aluno
					where pn_alu = 'Silvio')

/* d */
select id_prof as 'id professor', id_cur as 'id curso', nm_prof as 'Nome professor', tt_hs_prof as 'total horas professor', ((vl_hora_prof*5)/100)+vl_hora_prof as 'valor hora'
from professor
where vl_hora_prof <= ( select avg(vl_hora_prof) 
						from professor )
order by vl_hora_prof

/* e */
create view prof_vlhora_aumento
as select id_cur as 'id curso', id_prof as 'id professor', nm_prof as 'Nome professor', tt_hs_prof as 'Total salario hora', vl_hora_prof as 'salario hora', ((vl_hora_prof*5)/100)+vl_hora_prof as 'salario hora aumento'
from professor
where  vl_hora_prof <= ( select avg(vl_hora_prof) 
						from professor )

select * from prof_vlhora_aumento

