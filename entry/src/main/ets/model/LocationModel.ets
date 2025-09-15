export class LocationModel {
  name: string = '';
  latitude: number = 0;
  longitude: number = 0;

  constructor(
    name?: string,
    latitude?: number,
    longitude?: number
  ) {
    this.name = name || '';
    this.latitude = latitude || -1;
    this.longitude = longitude || -1;
  }
}