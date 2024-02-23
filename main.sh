#!/bin/bash
file_name="Students-list_1023.txt"
add_student() {
echo "Enter your email:"
read -r  email
echo "Enter your age:"
read -r  age
echo "Enter your ID:"
read -r  id
formatted_data="$age, $email, $id"
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

function update_student() {
    local student_id
    read -r -p "Enter student ID to update: " student_id

    if [ -f students-list_1023.txt ] && grep -q "$student_id" students-list_1023.txt; then
        local email; local age
        read -r -p "Enter updated email: " email
        read -r -p "Enter updated age: " age
        number_regex='^[0-9]+$'
        email_regex='^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        if [ -z "$email" ] || [ -z "$age" ]; then
            printf "\nAll fields are required\n"
        elif ! [[ $age =~ $number_regex ]]; then
            printf "\nAge must be a number\n"
        elif ! [[ $email =~ $email_regex ]]; then
            printf "\nInvalid email\n"
        else
            sed -i "/$student_id/c\\$email:$age:$student_id" students-list_1023.txt
            printf "\nStudent with ID %s updated successfully\n" "$student_id"
        fi
    else
        printf "\nStudent with ID %s not found\n" "$student_id"
    fi
while true; do
  echo "Menu:"
  echo "1. Add new student"
  echo "2. List students"
 echo "3. Delete student by ID"
 echo "4.Update student information"
 echo "5. Exit application"
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
      update_student
      ;;
    5)

      echo "Exiting the program."
      break
      ;;
    *)
	    echo "Invalid choice. Please enter a number between 1 and 5."
      ;;
  esac
done
echo "Program terminated."
 
