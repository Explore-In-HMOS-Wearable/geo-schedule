import { LocationModel } from './LocationModel';

export class EventModell {
  title: string = '';
  location?: LocationModel;
  startTime: number = 0;
  endTime: number = 0;
  reminder: string = '';

  constructor(
    title: string,
    startTime: number,
    endTime: number,
    reminder: string,
    location?: LocationModel) {
    this.title = title;
    this.location = location;
    this.startTime = startTime;
    this.endTime = endTime;
    this.reminder = reminder;
  }
}