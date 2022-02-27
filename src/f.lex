/*** Definition Section has one variable
which can be accessed inside yylex() 
[A-Z] {printf("%s capital letter\n", yytext);
       count++;}
.     {printf("%s not a capital letter\n", yytext);}
\n    {return 0;}
%%
  
/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){}
int main(){
  
// Explanation:
// yywrap() - wraps the above rule section
/* yyin - takes the file pointer 
          which contains the input*/
/* yylex() - this is the main flex function
          which runs the Rule Section*/
// yytext is the text in the buffer
  
// Uncomment the lines below 
// to take input from file
// FILE *fp;
// char filename[50];
// printf("Enter the filename: \n");
// scanf("%s",filename);
// fp = fopen(filename,"r");
// yyin = fp;
  
yylex();
printf("\nNumber of Capital letters " 
      "in the given input - %d\n", count);
  
return 0;
}
Output: 

￼

Example 2: Count the number of characters and number of lines in the input  

C
/* Declaring two counters one for number 
of lines other for number of characters */
%{
int no_of_lines = 0;
int no_of_chars = 0;
%}
  
/***rule 1 counts the number of lines, 
rule 2 counts the number of characters 
and rule 3 specifies when to stop 
taking input***/
%%
\n      ++no_of_lines;
.       ++no_of_chars;
end     return 0;
%%
  
/*** User code section***/
int yywrap(){}
int main(int argc, char **argv)
{
  
yylex();
printf("number of lines = %d, number of chars = %d\n",
       no_of_lines, no_of_chars );
  
return 0;
}
Output: 

￼

 

￼


￼
Like
32
Previous
C program to detect tokens in a C program
Next
Classification of Context Free Grammars
RECOMMENDED ARTICLES
Page :
1
2
Working of Lexical Analyzer in compiler
22, Aug 20
Introduction of Lexical Analysis
13, Jul 15
Lexical Error
02, Feb 22
How to Install Flex on Windows?
03, Dec 21
Fast I/O for Competitive Programming
31, Mar 16
You don’t need to type fast to be a developer
09, Nov 18
How to speed up the downloading of packages using apt-fast in Ubuntu?
30, Jul 19
Why Apache Kafka is so Fast?
31, May 20
Issues in the design of a code generator
14, Jun 18
10 Best CSS Generator Tools That You Can Use
20, Sep 21
Java Developer Learning Path – A Complete Roadmap
24, Feb 22
Design a concurrent server for handling multiple clients using fork()
24, Feb 22
Article Contributed By :
￼
shivani.mittal
@shivani.mittal
Vote for difficulty
Current difficulty : Easy
￼Easy
￼Normal
￼Medium
￼Hard
￼Expert
Improved By :
adnanirshad158
rajeev0719singh
vaibhavsinghtanwar
Article Tags :
Lex program
C Programs
Compiler Design
GBlog
￼Improve Article
Report Issue
Writing code in comment? Please use ide.geeksforgeeks.org, generate link and share the link here.


￼Load Comments
￼￼
WHAT'S NEW
￼
Complete Interview Preparation
View Details
￼
System Design-Live Classes for Working Professionals
View Details
￼
Data Structures & Algorithms- Self Paced Course
View Details
￼
MOST POPULAR IN C PROGRAMS
Strings in C
Arrow operator -> in C/C++ with Examples
Basics of File Handling in C
Header files in C/C++ and its uses
Program to print ASCII Value of a character
￼￼
MOST VISITED IN COMPILER DESIGN
Construction of LL(1) Parsing Table
Difference between Compiler and Interpreter
Language Processors: Assembler, Compiler and Interpreter
Introduction of Assembler
Types of Parsers in Compiler Design
￼￼
5th Floor, A-118,
Sector-136, Noida, Uttar Pradesh - 201305
feedback@geeksforgeeks.org
Company
About Us
Careers
Privacy Policy
Contact Us
Copyright Policy
Learn
Algorithms
Data Structures
Machine learning
CS Subjects
Video Tutorials
News
Technology
Work & Career
Business
Finance
Lifestyle
Languages
Python
Java
CPP
Golang
C#
Web Development
Web Tutorials
HTML
CSS
JavaScript
Bootstrap
Contribute
Write an Article
Pick Topics to Write
Write Interview Experience
Internships
Video Internship
@geeksforgeeks , Some rights reserved
￼
We use cookies to ensure you have the best browsing experience on our website. By using our site, y
and main() ***/
%{
int count = 0;
%}
  
/*** Rule Section has three rules, first rule 
matches with capital letters, second rule
matches with any character except newline and 
third rule does not take input after the enter***/
%%
[A-Z] {printf("%s capital letter\n", yytext);
       count++;}
.     {printf("%s not a capital letter\n", yytext);}
\n    {return 0;}
%%
  
/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){}
int main(){
  
// Explanation:
// yywrap() - wraps the above rule section
/* yyin - takes the file pointer 
          which contains the input*/
/* yylex() - this is the main flex function
          which runs the Rule Section*/
// yytext is the text in the buffer
  
// Uncomment the lines below 
// to take input from file
// FILE *fp;
// char filename[50];
// printf("Enter the filename: \n");
// scanf("%s",filename);
// fp = fopen(filename,"r");
// yyin = fp;
  
yylex();
printf("\nNumber of Capital letters " 
      "in the given input - %d\n", count);
  
return 0;
}