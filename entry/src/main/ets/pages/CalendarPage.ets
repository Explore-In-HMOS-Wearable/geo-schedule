import { EventModell } from '../model/EventModel';
import { LocationModel } from '../model/LocationModel';
import { NavigationService } from '../services/NavigationService';
import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStyleMode,
  LengthMetrics,
  LengthUnit
} from '@kit.ArkUI';

@Entry
@Component
export struct CalendarPage {
  @State now: number = Date.now();
  @State eventList: EventModell[] = [
    new EventModell('Team Meeting', this.now, this.now + 60 * 60 * 1000, '10 minutes before',
      new LocationModel('Office', 40.978, 29.092)),
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
    let dayStr = `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}`
    return this.eventList.some(event => this.formatDate(event.startTime) === dayStr)
  }

  // Timestamp → YYYY-MM-DD
  formatDate(time: number): string {
    let start = new Date(time)
    let year = start.getFullYear()
    let month = String(start.getMonth() + 1).padStart(2, '0')
    let day = String(start.getDate()).padStart(2, '0')
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

      Text(`Calendar ${this.currentYear}-${String(this.currentMonth).padStart(2, '0')}`)
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
                Image($r('app.media.dot'))
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