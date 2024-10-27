# Child Malnutrition Management Application

The Child Malnutrition Management Application is a mobile tool specifically designed for Public Health Midwives (PHMs). Its purpose is to simplify the collection, management, and analysis of child malnutrition data, thereby improving efficiency and accuracy in fieldwork. By centralizing and securing data entry processes, the application supports informed decisions and targeted interventions in child health and nutrition.

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
  - [Login Page](#login-page)
  - [Main Page](#main-page)
  - [Adding Patient Data](#adding-patient-data)
  - [Weight and Height Data Management](#weight-and-height-data-management)
  - [Graph Generation](#graph-generation)
  - [Collection Status Dashboard](#collection-status-dashboard)
  - [Document Generation](#document-generation)
- [Data Security & Storage](#data-security--storage)
- [Screenshots](#screenshots)
- [Installation & Setup](#installation--setup)
- [License](#license)

---

## Overview

This application allows PHMs to collect and analyze critical health and demographic data in their communities, focusing on child malnutrition. With a simple, user-friendly interface, it offers features that streamline patient data entry, tracking, and reporting, while maintaining high standards of data security. All data is stored and managed in Firebase Firestore, ensuring reliability and easy access.

---

## Features

### Login Page
The login screen is a secure entry point for users, requiring credentials to access the app's main functionalities. The design prioritizes ease of use and security.

<p align="left">
    <img src="https://github.com/user-attachments/assets/337171e7-9618-432e-aa3a-b71c20f679f8" alt="login page" width="300"/>
   <br>
   <strong>Figure 1:</strong>Login page
</p>

- **Username and Password Fields**: Clearly labeled input fields make logging in intuitive.
- **Secure Authentication**: User credentials are encrypted and securely transmitted, protecting sensitive data.
- **Error Handling**: Immediate feedback for invalid login attempts helps users correct issues easily.
- **Responsive and Accessible Design**: The layout adapts to different screen sizes and includes accessibility features like large buttons and clear text.

### Main Page
The main page serves as the app's control center, providing PHMs with quick access to essential features.

<p align="left">
   <img src="https://github.com/user-attachments/assets/88e62b5c-c466-44f7-bb05-62ddf7866725" alt="Main page" width="300"/>
   <br>
   <strong>Figure 2:</strong>Main page
</p>

- **Add New Patient**: PHMs can directly input data for new patients, filling out structured fields for demographics, nutritional status, and clinical records.
- **Show Patients**: This section provides a searchable database where PHMs can access patient profiles, including historical data and growth trends.
- **Collection Status**: A dashboard view offers an overview of data collection progress, showing key metrics to help track completion and consistency.

### Adding Patient Data
This page is designed to facilitate comprehensive data entry, with sections for child, family, and nutritional status information.

- **Child Details**: Capture essential information, including the child’s name, date of birth, address, ethnicity, school status, area type, and gender.
- **Family Status**: Record family composition, income, and socio-economic indicators such as vehicle ownership and smartphone usage.
- **Nutritional Status**: Track birth weight/height, current weight/height, activity level, calorie intake, and growth measurements over time.
- **Advanced Input Options**:
  - **Image Upload**: Attach images to add visual context to the data.
  - **Toggle Buttons & Dropdowns**: Easy-to-use options for binary choices and categorical data.
  - **Date Picker**: Calendar selection for accurate date inputs.

### Weight and Height Data Management
This section enables PHMs to record and manage anthropometric data, crucial for monitoring children’s growth.

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
