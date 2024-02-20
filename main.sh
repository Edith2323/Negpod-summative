#!/bin/bash
file_name="Students-list_1023.txt"
add_student() {
echo "Enter your email:"
read -r  email
echo "Enter your age:"
read -r  age
echo "Enter your ID:"
read -r  id
formatted_data="$age, $email, $id\n"
echo "$formatted_data" >> "$file_name"
echo "Student information added successfully."
}
delete_student() {
  echo "Enter the ID of the student to delete:"
  read -r id
  temp_file="temp.txt"
  while IFS=',' read -r name email student_id; do
    if [[ "$student_id" != "$id" ]]; then

      echo "$name,$email,$student_id" >> "$temp_file"
    fi
  done < "$file_name"
while IFS=',' read -r name email student_id; do
    if [[ "$student_id" != "$id" ]]; then
      # If ID doesn't match, write the line to the temporary file
      echo "$name,$email,$student_id" >> "$temp_file"
    fi
  done < "$file_name"
if grep -q "$id" "$file_name"; then
    echo "Student with ID '$id' not found."
  else
    echo "Student with ID '$id' deleted successfully."
  fi
}
list_student() {
	if [ -f "$file_name" ]; then
    echo "Here's the list of students:"
    cat "$file_name"
  else
    echo "No student information found in the file."
    fi
}
while true; do
  echo "Menu:"
  echo "1. Add new student"
  echo "2. List students"
 echo "3. Delete student by ID"
 echo "4. Exit the application"
  echo "Enter your choice:"
  read -r choice
case $choice in
    1)
      add_student
      ;;
    2)
      list_student
      ;;
    3)
     delete_student
      ;;
    4)
      echo "Exiting the program."
      break
      ;;
    *)
	    echo "Invalid choice. Please enter a number between 1 and 3."
      ;;
  esac
done

echo "Program terminated."
