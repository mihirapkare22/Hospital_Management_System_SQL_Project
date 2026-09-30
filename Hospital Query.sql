##########################################
# SQL QUERIES
##########################################

#1. Write a query in SQL to find the name of the nurse who are the head of their department and are registered.

SELECT * FROM NURSE
WHERE POSITION ='Head Nurse' AND REGISTERED = "YES";


#2. Write a query to obtain the avg cost of all the medical procedures.

SELECT AVG(COST) as Average_cost
FROM PROCEDURES;


#3 Write a query to obtain name and cost of the procedure whose cost is greater than 2000.

SELECT NAME as Procedure_Name,COST as Procedure_Cost 
FROM PROCEDURES
WHERE NOT COST < 2000;


#4. Second maximum cost of medical procedure

SELECT NAME,MAX(COST) as Procedure_cost
FROM PROCEDURES 
GROUP BY name
ORDER BY Procedure_cost DESC
LIMIT 1,1;


#5. Write a query in SQL to obtain the name of the patients starting with letter A.

SELECT CONCAT(NAME,' ',SURNAME) AS FULL_NAME,GENDER
FROM PATIENT
WHERE CONCAT(NAME,' ',SURNAME) LIKE 'A%';


#6. Write a query to obtain patient details having patient_id 11 to 20.

SELECT * FROM PATIENT
LIMIT 10,10;


#7.  Write a query in SQL to obtain the name of the physicians who are the head of each department

select p.name as Doctor_name,d.dept_name
from physician p
inner join department d
on p.employee_id = d.head;


#8. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement

select CONCAT(p.name,' ',p.SURNAME) as PATIENT_NAME,ph.NAME as PHY_WHO_DID_PRI_TREATMENT
FROM PATIENT p
LEFT JOIN PHYSICIAN ph
ON p.PRIMARY_CHECK = ph.employee_id;



#9. Write a query in SQL to obtain the name of the physician with the department who are done with affiliation.

select p.name as physician_name,d.dept_name as department_name
from physician p
inner join affiliated_with aw
on p.employee_id = aw.physician_id
inner join department d
on aw.department_id = d.department_id
where primary_affiliation='t';



#10. Write a query in SQL to obtain the patient name from which physician they get primary_checkup and also mention the patient diagnosis with prescription.

SELECT PH.employee_id,PH.NAME AS Physician_Name,PH.POSITION AS Designation,P.PATIENT_ID,CONCAT(P.NAME,' ',P.SURNAME) AS Patient_treated,P.GENDER,PD.DIAGNOSIS,PD.PRESCRIPTION
FROM PATIENT_DIAGNOSIS pd
LEFT JOIN Physician ph
ON pd.Physician_id = ph.employee_id
LEFT JOIN PATIENT P
ON P.PATIENT_ID = PD.PATIENT_ID; 


#11. Write a query in SQL to obtain the maximum cost of the medical procedure.

SELECT NAME,COST FROM PROCEDURES
WHERE COST IN (SELECT MAX(COST) FROM PROCEDURES);


#12. Write a query in SQL to obtain the details of patient who has diagnosed with chronic pain.

SELECT * FROM Patient
WHERE patient_id IN (SELECT Patient_ID FROM PATIENT_DIAGNOSIS WHERE Diagnosis = 'Chronic Pain');



#13.  Write a query in SQL to obtain the employeeid, physician name and position whose primary affiliation has not been done. 

SELECT * 
FROM Physician 
WHERE employee_id IN (SELECT physician_id 
                     FROM affiliated_with 
                     WHERE primary_affiliation = 'f'
                     );
                     
                     

#14. Write a query in SQL to obtain the procedure name and cost whose cost is greater than the avg cost of all the procedure.

SELECT name as Procedure_name,cost as Procedure_cost
FROM procedures
WHERE cost > (SELECT AVG(cost) FROM procedures);



#15. Write a query in SQL to obtain the physician name who are either head chief or senior in their respective department.

SELECT * 
FROM Physician 
WHERE position IN (SELECT position FROM Physician
                   WHERE position
                   LIKE '%Senior%' OR position LIKE '%Head Chief%'
                   );
