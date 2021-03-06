Select title
From Movie
Where director = 'Steven Spielberg';

Select distinct year
From Movie, Rating
Where stars > 3 and Movie.mID = Rating.mID order by year;

Select distinct name
From Reviewer, Rating
Where Reviewer.rID = Rating.rID and ratingDate IS NULL;

Select name, title, stars , ratingDate
From Movie, Rating, Reviewer
Where Movie.mID=Rating.mID and Reviewer.rID=Rating.rID Order by name, title, stars;

Select distinct name,title
From Reviewer,Movie
natural join (Select R2.rID, R2.mID
From Rating R1, Rating R2
Where R1.mID = R2.mID and R1.rID = R2.rID and R1.ratingDate < R2.ratingDate and R1.stars < R2.stars)

Select title, est
From Movie natural join (Select mID, max(stars) as est
From Rating
Group by mID) Order by title

Select title, est
From Movie natural join (Select mID, max(stars)-min(stars) as est
From Rating
Group by mID) Order by est desc,title

Select distinct (Select avg(individualavg) as avgbefore
From Movie join (Select mID, avg(stars) as individualavg
From Rating
Group by mID) B
Where Movie.mID=B.mID and year < 1980) - 
(Select avg(individualavg) as avgafter
From Movie join (Select mID, avg(stars) as individualavg
From Rating
Group by mID) B
On Movie.mID=B.mID and year > 1980) 
From Movie, Rating


Select name
From (Select ID1
From Friend
Where ID2 in (Select ID
From Highschooler
Where name='Gabriel')) join Highschooler
Where ID1=Highschooler.ID

Select SN1, G1, name as SN2, grade as G2
From Highschooler join (Select name as SN1, grade as G1 , studentID2
                        From Highschooler join (Select ID1 as studentID1, ID2 as studentID2
                        From Likes inner join (Select H1.ID as A,H2.ID as B
                        From Highschooler H1, Highschooler H2
                        Where H1.ID<>H2.ID and H1.grade >= H2.grade +2) C on (ID1=A and ID2=B) ) D on (ID=studentID1)) E on (ID=studentID2); 
            
Select name1, grade1, H2.name as name2, H2.grade as grade2
From (
Select H1.name as name1, H1.grade as grade1, IID2
From Highschooler H1 join 
(Select L1.ID1 as IID1, L1.ID2 as IID2 
From Likes L1, Likes L2 
Where L1.ID1=L2.ID2 and L1.ID2=L2.ID1) B on (H1.ID=IID1))  C join Highschooler H2 on (IID2=H2.ID)
Where name1<H2.name

Select name, grade
From Highschooler
Where ID not in (Select ID1 as ID
From Likes
Union 
Select ID2 as ID
From Likes) Order By grade, name



Select name1, grade1, H2.name as name2, H2.grade as grade2
From Highschooler H2 join (
Select distinct H1.name as name1, H1.grade as grade1, ID2
From Highschooler H1 join 
(Select ID1,ID2
From Likes
Where ID2 not in (Select ID1 From Likes)) B on H1.ID=ID1) C on (ID2=H2.ID)


Select name, grade
From Highschooler
Where ID not in (
Select IID1
From (Select H1.name as name1, H1.grade as grade1, IID1, IID2
From Highschooler H1 join (
Select F1.ID1 as IID1, F2.ID2 as IID2
From Friend F1, Friend F2
Where F1.ID1=F2.ID1) A on (H1.ID=IID1)) B join Highschooler H2 on (IID2=H2.ID)
Where grade1<>H2.grade) Order by grade, name 


Select name1, grade1, name2, grade2, H3.name as name3, H3.grade as grade3
From Highschooler H3 join 
(Select name1, grade1 , H2.name as name2, H2.grade as grade2, CC1
From Highschooler H2 join 
(Select H1.name as name1, H1.grade as grade1, LL2, CC1
From Highschooler H1 join
(Select LL1, LL2, F3.ID2 as CC1
From Friend F2, Friend F3,
(Select L1.ID1 as LL1, L1.ID2 as LL2
From Likes L1
Where not exists (select * From Friend F1 Where F1.ID1=L1.ID1 and F1.ID2=L1.ID2)) A 
Where F2.ID1=LL1 and F3.ID1=LL2 and F2.ID2 = F3.ID2) B on (H1.ID=LL1)) C on (H2.ID=LL2)) D on (H3.ID=CC1)


Select distinct (Select count () 
From Highschooler ) - (Select count (distinct name) From Highschooler)
From Highschooler


Select name, grade
From Highschooler join (
Select count (distinct ID1) as amount, ID2
From Likes
Group by ID2) A on (ID=ID2)
Where amount >1