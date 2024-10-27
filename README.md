# Child Malnutrition Management Application

A mobile application designed to streamline data collection, management, and analysis for child malnutrition. Tailored for Public Health Midwives (PHMs), the app enhances efficiency and accuracy, aiding in informed decision-making and targeted interventions.

## Table of Contents
- [Features Overview](#features-overview)
- [Data Security & Storage](#data-security--storage)
- [Screenshots](#screenshots)
- [Installation & Setup](#installation--setup)
- [License](#license)

## Features Overview

### Login Page
The login page ensures secure access with fields for username, password, and an optional "Remember Me" feature.

- **User Authentication**
  - Simple, labeled fields for credentials
  - Secure authentication protocols for data protection
- **Error Handling**
  - Instant feedback for invalid login attempts
  - Clear error messages for user assistance
- **Responsive Design**
  - Optimized for multiple screen sizes and accessible design elements

### Main Page
Central hub for interactions, offering three primary options to support PHMs in managing child malnutrition data.

- **Add New Patient**
  - Input structured data for each patient
- **Show Patients**
  - Access database for detailed profiles and historical data
- **Collection Status**
  - Overview of data collection progress and metrics

### Adding Patient Data Page
Enables PHMs to enter comprehensive data on children, their families, and nutritional statuses.

- **Sections:**
  - **Child Details:** Name, contact info, date of birth, etc.
  - **Family Status:** Household composition, income, and other socio-economic factors
  - **Nutritional Status:** Birth/current weight and height, calorie intake, growth metrics
- **Additional Features:**
  - Image upload for visual context
  - Toggle buttons, dropdowns, and date pickers for efficient data entry

### Weight and Height Data Management
A section dedicated to tracking children’s growth, allowing PHMs to maintain accurate and current records.

- **Key Features:**
  - Data entry for weight/height with real-time validation
  - Update/edit options for existing records
  - Secure storage in Firebase Firestore with offline support

### Graph Generation Page
Visualizes growth patterns through various interactive graphs.

- **Growth Tracking:**
  - Height vs. Age, Weight vs. Age, and Weight vs. Height graphs
- **Interactive Visualization:**
  - Zoom/pan capabilities for detailed data analysis
  - Filter options to focus on specific growth phases

### Collection Status Dashboard
Provides a visual overview of the collected data, aiding PHMs in assessing community nutritional and health statuses.

- **Dashboard Charts:**
  - Gender and Area Type Distribution Donut Charts
  - Activity Status and Vehicle Type Bar Charts
  - Total Patients Count for an overall snapshot

### Document Generation
Generates detailed reports in PDF and Excel formats, useful for both individual patient records and aggregated data.

- **Reports:**
  - Individual and aggregated PDF/Excel documents
  - Flexible for reporting, analysis, and record-keeping

---

## Data Security & Storage

Data is securely stored in Firebase Firestore, supporting real-time updates, offline data entry, and automatic syncing.

---

## Screenshots

- **Login Page:** ![Figure 1 - Login Page]
- **Main Page:** ![Figure 2 - Main Page]
- **Family Status:** ![Figure 3 - Family Status]
- **Patient Data Entry:** ![Figure 4 - Child Details]
- **Collection Status Dashboard:** ![Figure 11 - Collection Status]

---

## Installation & Setup

1. Clone the repository
   ```bash
   git clone https://github.com/username/child-malnutrition-management.git


