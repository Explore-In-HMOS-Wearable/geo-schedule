import { EventModell } from "../model/EventModel";
import { LocationModel } from "../model/LocationModel";
import { NavigationService } from "../services/NavigationService";
import { ArcButton, ArcButtonOptions, ArcButtonPosition,
  ArcButtonStyleMode,
  LengthMetrics, LengthUnit } from "@kit.ArkUI";

@Entry
@Component
export struct CalendarPage {
  @State now: number = Date.now();
  @State eventList: EventModell[] = [
    new EventModell("Team Meeting", this.now, this.now + 60 * 60 * 1000, "10 minutes before",
      new LocationModel("Office", 40.978, 29.092)),
    new EventModell("Doctor Appointment", this.now + 2 * 60 * 60 * 1000, this.now + 3 * 60 * 60 * 1000,
      "30 minutes before", new LocationModel("Hospital", 40.990, 29.050)),
    new EventModell("Lunch with Sarah", this.now + 5 * 60 * 60 * 1000, this.now + 6 * 60 * 60 * 1000, "1 hour before",
      new LocationModel("Cafe Milano", 41.005, 29.035)),
    new EventModell("Project Deadline", this.now + 24 * 60 * 60 * 1000, this.now + 25 * 60 * 60 * 1000, "1 day before"),
    new EventModell("Yoga Class", this.now + 26 * 60 * 60 * 1000, this.now + 27 * 60 * 60 * 1000, "2 hours before",
      new LocationModel("Wellness Studio", 41.012, 28.970)),
    new EventModell("Conference Call", this.now + 48 * 60 * 60 * 1000, this.now + 49 * 60 * 60 * 1000,
      "15 minutes before"),
    new EventModell("Friend's Birthday Party", this.now + 72 * 60 * 60 * 1000, this.now + 76 * 60 * 60 * 1000,
      "2 days before", new LocationModel("Home", 40.999, 29.111)),
    new EventModell("Business Trip", this.now + 96 * 60 * 60 * 1000, this.now + 144 * 60 * 60 * 1000, "1 day before",
      new LocationModel("Airport", 41.275, 28.751)),
    new EventModell("Dentist Appointment", this.now + 160 * 60 * 60 * 1000, this.now + 161 * 60 * 60 * 1000,
      "30 minutes before"),
    new EventModell("Weekly Planning", this.now + 200 * 60 * 60 * 1000, this.now + 201 * 60 * 60 * 1000,
      "1 hour before", new LocationModel("Office Meeting Room", 41.000, 29.090)),
  ];

  getDaysInMonth(year: number, month: number): number[] {
    let date = new Date(year, month, 0);
    let days = date.getDate();
    let result: number[] = [];
    for (let i = 1; i <= days; i++) {
      result.push(i);
    }
    return result;
  }

  hasEvent(day: number, year: number, month: number): boolean {
    let dayStr = `${year}-${String(month).padStart(2, "0")}-${String(day).padStart(2, "0")}`
    return this.eventList.some(event => this.formatDate(event.startTime) === dayStr)
  }

  // Timestamp → YYYY-MM-DD
  formatDate(time: number): string {
    let start = new Date(time)
    let year = start.getFullYear()
    let month = String(start.getMonth() + 1).padStart(2, "0")
    let day = String(start.getDate()).padStart(2, "0")
    return `${year}-${month}-${day}`
  }

  @State currentYear: number = 0
  @State currentMonth: number = 0
  navigationService: NavigationService = NavigationService.getInstance();

  aboutToAppear(): void {
    let currentYear = new Date(this.now).getFullYear();
    let currentMonth = new Date(this.now).getMonth() + 1; // 1-12

    this.currentYear = currentYear
    this.currentMonth = currentMonth
  }

  build() {
    Column() {

      Text(`Calendar ${this.currentYear}-${String(this.currentMonth).padStart(2, "0")}`)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .padding(10)
        .fontColor(Color.Green)

      Grid() {
        ForEach(this.getDaysInMonth(this.currentYear, this.currentMonth), (day: number) => {
          GridItem() {
            Column({ space: 2 }) {
              Text(day.toString())
                .fontSize(10)
                .fontWeight(FontWeight.Medium)

              if (this.hasEvent(day, this.currentYear, this.currentMonth)) {
                Image($r("app.media.dot"))
                  .width(10)
                  .height(10)
              }
            }
            .padding({top: 2, bottom: 6, left:2})
          }
        })
      }
      .scrollBar(BarState.Off)
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
      .height('50%')
      .width('80%')

      ArcButton({
        options: new ArcButtonOptions({
          label: 'Back',
          fontSize: new LengthMetrics(10, LengthUnit.FP),
          position: ArcButtonPosition.BOTTOM_EDGE,
          styleMode: ArcButtonStyleMode.NORMAL_LIGHT,
          /*fontMargin: {
            top: new LengthMetrics(10, LengthUnit.VP)
          },*/
          onClick: () => {
            this.navigationService.pageInfos.pushPath({ name: 'MainPage' })
          }
        })
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Black)
    .justifyContent(FlexAlign.Center)
  }
}