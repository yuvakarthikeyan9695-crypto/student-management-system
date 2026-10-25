// Shared Student Data Management using localStorage

const DEFAULT_STUDENTS = [
    {
        id: 1,
        name: "Arun",
        roll: "CS101",
        dept: "CSE",
        mobile: "9876543210",
        email: "arun@gmail.com",
        password: "••••••",
        confirmPassword: "••••••",
        dateTime: "28/05/2025 10:30 AM"
    },
    {
        id: 2,
        name: "Priya",
        roll: "EC102",
        dept: "ECE",
        mobile: "9123456780",
        email: "priya@gmail.com",
        password: "••••••",
        confirmPassword: "••••••",
        dateTime: "28/05/2025 10:35 AM"
    },
    {
        id: 3,
        name: "Karthik",
        roll: "IT103",
        dept: "IT",
        mobile: "9988776655",
        email: "karthik@gmail.com",
        password: "••••••",
        confirmPassword: "••••••",
        dateTime: "28/05/2025 10:40 AM"
    }
];

function getStudents() {
    const data = localStorage.getItem("registered_students");
    if (!data) {
        localStorage.setItem("registered_students", JSON.stringify(DEFAULT_STUDENTS));
        return DEFAULT_STUDENTS;
    }
    try {
        return JSON.parse(data);
    } catch (e) {
        return DEFAULT_STUDENTS;
    }
}

function saveStudents(students) {
    localStorage.setItem("registered_students", JSON.stringify(students));
}

function formatCurrentDateTime() {
    const now = new Date();
    const day = String(now.getDate()).padStart(2, '0');
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const year = now.getFullYear();
    
    let hours = now.getHours();
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12; // 12 instead of 0
    const strHours = String(hours).padStart(2, '0');

    return `${day}/${month}/${year}\n${strHours}:${minutes} ${ampm}`;
}
