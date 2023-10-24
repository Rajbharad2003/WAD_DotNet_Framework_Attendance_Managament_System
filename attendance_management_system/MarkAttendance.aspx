﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="MarkAttendance.aspx.cs" Inherits="attendance_management_system.MarkAttendance" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            width: 80%;
            margin: 0 auto;
        }

        .form-container {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        .form-label {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .form-dropdown {
            width: 100% !important;
            padding: 10px !important;
            border-radius: 5px !important;
            border: 1px solid #ccc !important;
            margin-bottom: 20px !important;
        }

        .table-container {
            margin-top: 20px;
        }

        .student-table {
            width: 100%;
            border-collapse: collapse;
        }

        .student-table th,
        .student-table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        .student-table th {
            background-color: #f2f2f2;
        }

        .add-attendance-link {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Mark Attendance</h2>
        <div class="form-container">
            <div class="form-group">
                <label for="ddlSubject" class="form-label">Select Subject:</label>
                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-dropdown" AutoPostBack="false">
                    <asp:ListItem Text="Select Subject" Value="" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="table-container">
            <table class="student-table">
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Semester</th>
                        <th>Add Attendance</th>
                    </tr>
                </thead>
                <tbody id="studentTableBody">
                    <!-- Table body will be populated using AJAX -->
                </tbody>
            </table>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // Use event delegation to handle change events for any element with id containing "ddlSubject"
            $(document).on('change', '[id*="ddlSubject"]', function () {
                var subject_name = $(this).val();
                console.log("Dropdown changed");
                if (subject_name !== "") {
                    $.ajax({
                        type: "POST",
                        url: "StudentService.asmx/GetStudentsBySemester",
                        data: JSON.stringify({ subject_name: subject_name }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var studentTableBody = $('#studentTableBody');
                            studentTableBody.empty();
                            $.each(response.d, function (index, student) {
                                var row = "<tr><td>" + student.StudentID + "</td><td>" + student.Name + "</td><td>" + student.sem + "</td><td><a href='AddAttendance.aspx?studentID=" + student.StudentID + "&subjectName=" + subject_name + "'>Add</a></td></tr>";
                                studentTableBody.append(row);
                                console.log("Hi");
                            });
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX Request Error:", error);
                        }
                    });
                }
                else {
                    console.log("Hello");
                }
            });
        });
    </script>
</asp:Content>