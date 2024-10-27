# Child Malnutrition Management Application

The Child Malnutrition Management Application is a mobile tool specifically designed for Public Health Midwives (PHMs). Its purpose is to simplify the collection, management, and analysis of child malnutrition data, thereby improving efficiency and accuracy in fieldwork. By centralizing and securing data entry processes, the application supports informed decisions and targeted interventions in child health and nutrition.

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
  - [Login Page](#login-page)
  - [Main Page](#main-page)
  - [Adding Patient Data](#adding-patient-data)
  - [Viewing Patient Data](#viewing-patient-data)
  - [Editing Patient Data](#editing-patient-data)
  - [Deleting Patient Data](#deleting-patient-data)
  - [Weight and Height Data Management](#weight-and-height-data-management)
  - [Graph Generation](#graph-generation)
  - [Collection Status Dashboard](#collection-status-dashboard)
  - [Document Generation](#document-generation)
- [Data Security & Storage](#data-security--storage)
- [Installation & Setup](#installation--setup)
- [License](#license)

---

## Overview

This application allows PHMs to collect and analyze critical health and demographic data in their communities, focusing on child malnutrition. With a simple, user-friendly interface, it offers features that streamline patient data entry, tracking, and reporting, while maintaining high standards of data security. All data is stored and managed in Firebase Firestore, ensuring reliability and easy access.

---

## Features

### Login Page
The login screen is a secure entry point for users, requiring credentials to access the app's main functionalities. The design prioritizes ease of use and security.

| <img src="https://github.com/user-attachments/assets/337171e7-9618-432e-aa3a-b71c20f679f8" alt="login page" width="300" /> |
|:--:|
| Figure 1: Login page |

- **Username and Password Fields**: Clearly labeled input fields make logging in intuitive.
- **Secure Authentication**: User credentials are encrypted and securely transmitted, protecting sensitive data.
- **Error Handling**: Immediate feedback for invalid login attempts helps users correct issues easily.
- **Responsive and Accessible Design**: The layout adapts to different screen sizes and includes accessibility features like large buttons and clear text.

### Main Page
The main page serves as the app's control center, providing PHMs with quick access to essential features.

| <img src="https://github.com/user-attachments/assets/88e62b5c-c466-44f7-bb05-62ddf7866725" alt="Main page" width="300" /> |
|:--:|
| Figure 2: Main page |

- **Add New Patient**: PHMs can directly input data for new patients, filling out structured fields for demographics, nutritional status, and clinical records.
- **Show Patients**: This section provides a searchable database where PHMs can access patient profiles, including historical data and growth trends.
- **Collection Status**: A dashboard view offers an overview of data collection progress, showing key metrics to help track completion and consistency.

### Adding Patient Data
This page is designed to facilitate comprehensive data entry, with sections for child, family, and nutritional status information.

| <img src="https://github.com/user-attachments/assets/e066482f-c160-48ba-aeeb-c324913d82f4" alt="Adding Patient Data Form" width="300" /> | <img src="https://github.com/user-attachments/assets/a2c528e6-b84b-4810-b19b-558e6e7971f0" alt="Editing Patient Data" width="300" /> | <img src="https://github.com/user-attachments/assets/115206cd-3419-4883-b34e-cda6104f2d65" alt="Deleting Patient Data" width="300" /> |
|:--:|:--:|:--:|
| Figure 3: Add child details | Figure 4: Add family status | Figure 5: Add nutrition details |

- **Child Details**: Capture essential information, including the child’s name, date of birth, address, ethnicity, school status, area type, and gender.
- **Family Status**: Record family composition, income, and socio-economic indicators such as vehicle ownership and smartphone usage.
- **Nutritional Status**: Track birth weight/height, current weight/height, activity level, calorie intake, and growth measurements over time.
- **Advanced Input Options**:
  - **Image Upload**: Attach images to add visual context to the data.
  - **Toggle Buttons & Dropdowns**: Easy-to-use options for binary choices and categorical data.
  - **Date Picker**: Calendar selection for accurate date inputs.

### Viewing Patient Data
The patient data view page provides an organized and efficient way to access and manage patient records. The data is categorized into three distinct sections for easier navigation:

| <img src="https://github.com/user-attachments/assets/c64f573c-2f33-44f9-8259-1ac9417db927" alt="Children Details" width="300" /> | <img src="https://github.com/user-attachments/assets/d474ec2a-ee30-4e8c-b960-e078754bf293" alt="Generate PDF & Excel" width="300" /> | <img src="https://github.com/user-attachments/assets/9ae79777-935a-4472-9a3c-8ecd1547662f" alt="View Child Details" width="300" /> |
|:--:|:--:|:--:|
| Figure 6: View All Children Details | Figure 7: Generate PDF & Excel | Figure 8: View One Child Details |

- **All Patients**: This section displays a complete list of all patient records, allowing users to quickly scan through the entire database.
- **Urban Patients**: Filtered specifically for patients residing in urban areas, this section helps focus on demographics pertinent to urban health initiatives.
- **State Patients**: This category includes patients grouped by specific states, enabling users to analyze data based on geographical distribution.
- **Pagination**: Navigate through large datasets with pagination controls, improving the user experience when dealing with extensive records.

### Editing Patient Data
Users can edit existing patient records to ensure that the information remains current and accurate. This includes:

| <img src="https://github.com/user-attachments/assets/90cb8c26-c18f-42eb-af7b-a56dd9a52a73" alt="Edit Child Details 1" width="300" /> | <img src="https://github.com/user-attachments/assets/eaf94df3-6770-4cb6-9f20-caf0bad611af" alt="Edit Child Details 2" width="300" /> |
|:--:|:--:|
| Figure 9: Edit Child Details | Figure 10: Save Child Details |

- **Direct Editing**: Clickable fields that allow users to modify information directly within the patient profile.
- **Validation**: Ensures that all required fields are filled out and that the data adheres to specific formats before submission.

### Deleting Patient Data
To maintain an organized database, users have the option to delete patient records:

| <img src="https://github.com/user-attachments/assets/a4fee9fe-e96f-4583-8655-dfb3260b5159" alt="Delete Child Details" width="300" /> |
|:--:|
| Figure 10: Delete Child Details |

- **Confirmation Prompt**: A confirmation dialog to prevent accidental deletions.
- **Permanent Removal**: Deleted data is permanently removed from the system, ensuring that the database remains accurate and up-to-date.

### Weight and Height Data Management
This section enables PHMs to record and manage anthropometric data, crucial for monitoring children’s growth.

| <img src="https://github.com/user-attachments/assets/0462746e-6e92-475c-b9e8-ed326c16b7a3" alt="Save Weight Height" width="300" /> | <img src="https://github.com/user-attachments/assets/726e01df-1244-45b2-baf2-b63efdb6d3fc" alt="Add Weight Height" width="300" /> |
|:--:|:--:|
| Figure 11: View Weight & Height | Figure 12: Add Weight & Height |

| <img src="https://github.com/user-attachments/assets/e32ec02b-9922-4ce4-ada8-d8a92f29b29d" alt="Edit Weight Height" width="300" /> | <img src="https://github.com/user-attachments/assets/c5f17c2b-45e9-4d41-9cd7-df96e24fd08d" alt="Delete Weight Height" width="300" /> |
|:--:|:--:|
| Figure 13: Edit Weight & Height | Figure 14: Delete Weight & Height |


- **Data Entry**: Capture and validate weight/height entries to ensure accuracy.
- **Edit Existing Data**: Modify records to keep data current and correct errors.
- **Delete Data**: Remove outdated or incorrect entries with confirmation prompts to prevent accidental loss.
- **Secure Data Storage**: Data is stored in Firestore, accessible in real-time and protected for security.

### Graph Generation
The graph generation page provides visual tools to analyze growth trends over time.

- **Height vs. Age and Weight vs. Age Graphs**: Track growth patterns against standardized metrics.
- **Weight vs. Height Graph**: Assess body proportions to monitor healthy development.
- **Interactive Visualization**:
  - **Zoom and Pan**: Enables detailed examination of specific data points.
  - **Dynamic Updates**: Automatically updates graphs as new data is added.
- **Customizable Views**: Filter by time periods or age groups for focused analysis.

### Collection Status Dashboard
A comprehensive dashboard offers a high-level view of key demographic and nutritional indicators.

- **Gender and Area Distribution Charts**: Donut charts show gender ratio and urban/estate demographics.
- **Activity Status Bar Chart**: Visualize the distribution of engagement levels among patients.
- **Total Patient Count**: Summarizes the total number of tracked patients for an immediate overview.
- **Vehicle Ownership Chart**: Provides insights into socio-economic conditions based on household vehicle types.

### Document Generation
Generate PDF and Excel reports to streamline data sharing and record-keeping.

- **Individual and Aggregated Reports**:
  - **PDF for Single Patient**: Generate detailed reports for individual patients.
  - **PDF for All Patients**: Create an overview of the entire patient dataset.
  - **Excel Exports**: Flexible for data analysis and sharing, available for both single and all patients.

---

## Data Security & Storage

All data is securely stored in Firebase Firestore, offering real-time access and synchronization across devices. Offline data entry and automatic syncing ensure data is reliably captured and updated without data loss, even when internet connectivity is limited.

---

## Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/username/child-malnutrition-management.git
