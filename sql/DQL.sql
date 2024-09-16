SELECT s.local_n INTO local_next_n, s.local_s INTO local_next_s, s.local_l INTO local_next_l, s.local_o INTO local_next_o FROM sala s, personagem p WHERE s.id_local = p;

SELECT COUNT(*) INTO qtd_ids FROM qtd_salas WHERE id_local = NEW.id_local;

SELECT NEW.local_n INTO qtd_ids_n, NEW.local_s INTO qtd_ids_s, NEW.local_l INTO qtd_ids_l, NEW.local_o INTO qtd_ids_o FROM qtd_salas WHERE id_local = NEW.id_local;

select s.id_local, s.local_n, s.local_s, count(*) 
from sala s 
where s.local_n = s.local_s
group by s.id_local, s.local_n, s.local_s
having count(*) >= 1;

select s.id_local, s.local_n, s.local_l, count(*) 
from sala s 
where s.local_n = s.local_l
group by s.id_local, s.local_n, s.local_l
having count(*) >= 1;

select s.id_local, s.local_n, s.local_o, count(*) 
from sala s 
where s.local_n = s.local_o
group by s.id_local, s.local_n, s.local_o
having count(*) >= 1;

select s.id_local, s.local_s, s.local_l, count(*) 
from sala s 
where s.local_s = s.local_l
group by s.id_local, s.local_s, s.local_l
having count(*) >= 1;

select s.id_local, s.local_s, s.local_o, count(*) 
from sala s 
where s.local_s = s.local_o
group by s.id_local, s.local_s, s.local_o
having count(*) >= 1;

select s.id_local, s.local_l, s.local_o, count(*) 
from sala s 
where s.local_l = s.local_o
group by s.id_local, s.local_l, s.local_o
having count(*) >= 1;

SELECT s.id_local, s.local_n, s.local_s, s.local_l, s.local_o FROM sala s, personagem p WHERE s.id_local = p.localizacao