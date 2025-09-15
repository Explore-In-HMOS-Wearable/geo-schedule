import { EventModell } from "../model/EventModel";
import { LocationModel } from "../model/LocationModel";

// now
let now = Date.now();

//  list
export const eventList: EventModell[] =
  [
  new EventModell
  (
    "Team Meeting",
    now,
    now + 60 * 60 * 1000,
    "10 minutes before",
    new LocationModel("Office", 40.978, 29.092)
  ),
  new EventModell
  (
    "Doctor Appointment",
    now + 2 * 60 * 60 * 1000,
    now + 3 * 60 * 60 * 1000,
    "30 minutes before",
    new LocationModel("Hospital", 40.990, 29.050)
  ),
  new EventModell
  (
    "Lunch with Sarah",
    now + 5 * 60 * 60 * 1000,
    now + 6 * 60 * 60 * 1000,
    "1 hour before",
    new LocationModel("Cafe Milano", 41.005, 29.035)
  ),
  new EventModell
  (
    "Project Deadline",
    now + 24 * 60 * 60 * 1000,
    now + 25 * 60 * 60 * 1000,
    "1 day before"
  ),
  new EventModell
  (
    "Yoga Class",
    now + 26 * 60 * 60 * 1000,
    now + 27 * 60 * 60 * 1000,
    "2 hours before",
    new LocationModel("Wellness Studio", 41.012, 28.970)
  ),
  new EventModell
  (
    "Conference Call",
    now + 48 * 60 * 60 * 1000,
    now + 49 * 60 * 60 * 1000,
    "15 minutes before"
  ),
  new EventModell
  (
    "Friend's Birthday Party",
    now + 72 * 60 * 60 * 1000,
    now + 76 * 60 * 60 * 1000,
    "2 days before",
    new LocationModel("Home", 40.999, 29.111)
  ),
  new EventModell
  (
    "Business Trip",
    now + 96 * 60 * 60 * 1000,
    now + 144 * 60 * 60 * 1000,
    "1 day before",
    new LocationModel("Airport", 41.275, 28.751)
  ),
  new EventModell
  (
    "Dentist Appointment",
    now + 160 * 60 * 60 * 1000,
    now + 161 * 60 * 60 * 1000,
    "30 minutes before"
  ),
  new EventModell
  (
    "Weekly Planning",
    now + 200 * 60 * 60 * 1000,
    now + 201 * 60 * 60 * 1000,
    "1 hour before",
    new LocationModel("Office Meeting Room", 41.000, 29.090)
  ),

  new EventModell
  (
    "Team Sync",
    now + 210 * 60 * 60 * 1000,
    now + 211 * 60 * 60 * 1000,
    "15 minutes before",
    new LocationModel("Office", 40.978, 29.092)
  ),
  new EventModell
  (
    "Checkup Appointment",
    now + 212 * 60 * 60 * 1000,
    now + 213 * 60 * 60 * 1000,
    "30 minutes before",
    new LocationModel("Hospital", 40.990, 29.050)
  ),
  new EventModell
  (
    "Brunch with Sarah",
    now + 215 * 60 * 60 * 1000,
    now + 216 * 60 * 60 * 1000,
    "1 hour before",
    new LocationModel("Cafe Milano", 41.005, 29.035)
  ),
  new EventModell
  (
    "Project Review",
    now + 240 * 60 * 60 * 1000,
    now + 241 * 60 * 60 * 1000,
    "1 day before"
  ),
  new EventModell
  (
    "Pilates Class",
    now + 246 * 60 * 60 * 1000,
    now + 247 * 60 * 60 * 1000,
    "2 hours before",
    new LocationModel("Wellness Studio", 41.012, 28.970)
  ),
  new EventModell
  (
    "Team Call",
    now + 248 * 60 * 60 * 1000,
    now + 249 * 60 * 60 * 1000,
    "15 minutes before"
  ),
  new EventModell
  (
    "Friend's Party",
    now + 272 * 60 * 60 * 1000,
    now + 276 * 60 * 60 * 1000,
    "2 days before",
    new LocationModel("Home", 40.999, 29.111)
  ),
  new EventModell
  (
    "Business Flight",
    now + 296 * 60 * 60 * 1000,
    now + 344 * 60 * 60 * 1000,
    "1 day before",
    new LocationModel("Airport", 41.275, 28.751)
  ),
  new EventModell
  (
    "Dental Checkup",
    now + 360 * 60 * 60 * 1000,
    now + 361 * 60 * 60 * 1000,
    "30 minutes before"
  ),
  new EventModell
  (
    "Planning Meeting",
    now + 400 * 60 * 60 * 1000,
    now + 401 * 60 * 60 * 1000,
    "1 hour before",
    new LocationModel("Office Meeting Room", 41.000, 29.090)
  ),
];

