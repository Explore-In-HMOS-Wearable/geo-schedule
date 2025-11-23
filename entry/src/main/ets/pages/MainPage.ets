import { ArcList, ArcListItem, ArcListAttribute } from '@kit.ArkUI';
import { EventModell } from '../model/EventModel';
import { NavigationService } from '../services/NavigationService';

@Entry
@Component
export struct MainPage {
  navigationService: NavigationService = NavigationService.getInstance();
  @State events: EventModel[] = [
    {
      id: 1,
      title: 'Team Meeting',
      location: 'Office Room A',
      startTime: '2025-09-01 14:00',
      endTime: '2025-09-01 15:00',
      reminder: '30 min before'
    },
    {
      id: 2,
      title: 'Dinner with Alex',
      location: 'Italian Restaurant',
      startTime: '2025-09-02 19:00',
      endTime: '2025-09-02 21:00',
      reminder: '1 hr before'
    },
    {
      id: 3,
      title: 'Morning Run',
      location: 'City Park',
      startTime: '2025-09-03 07:00',
      endTime: '2025-09-03 08:00',
      reminder: '10 min before'
    }
  ]
  @StorageLink('eventList') eventList: EventModell[] = [];

  onPageShow(): void {
    console.info(`Succeeded in adding event, id -> ${this.eventList[0]}`);
  }

  aboutToAppear(): void {
    console.info(`Succeeded in adding event, id -> ${this.eventList.length}`);
  }

  formatDateTime(time: number): string {
    let start = new Date(time)
    let year = start.getFullYear()
    let month = String(start.getMonth() + 1).padStart(2, '0')
    let day = String(start.getDate()).padStart(2, '0')
    let hours = String(start.getHours()).padStart(2, '0')
    let minutes = String(start.getMinutes()).padStart(2, '0')

    let dateTime = `${year}-${month}-${day} ${hours}:${minutes}`
    return dateTime
  }

  build() {
    ArcList({
      initialIndex: 1
    }) {
      ArcListItem() {
        Image($r('app.media.calendar')).width(55)
      }

      ArcListItem() {
        Button('Create Event')
          .fontSize(16)
          .backgroundColor(Color.Green)
          .onClick(() => {
            this.navigationService.pageInfos.pushPath({ name: 'EventPage' })
          })
          .margin(10)
      }

      ArcListItem() {
        Button('Calendar')
          .fontSize(16)
          .backgroundColor(Color.Green)
          .onClick(() => {
            this.navigationService.pageInfos.pushPath({ name: 'CalendarPage' })
          })
      }

      ForEach(this.eventList, (event: EventModell) => {
        ArcListItem() {
          Column({ space: 4 }) {
            Text(event.title)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Text('📍 ' + event.location?.name)
              .fontSize(8)
              .fontColor(Color.Black)

            Text('⏰ ' + this.formatDateTime(event.startTime) + ' – ' + this.formatDateTime(event.endTime))
              .fontSize(8)
              .fontColor(Color.Black)

            Row({ space: 10 }) {
              Button('Edit')
                .backgroundColor(Color.Orange)
                .onClick(() => console.info(`Edit ${event.title}`))
                .height(20)
                .fontSize(8)

              Button('Delete')
                .backgroundColor(Color.Red)
                .onClick(() => {
                  this.eventList = this.eventList.filter(e => e.title !== event.title)
                })
                .height(20)
                .fontSize(8)
            }
          }
          .padding(10)
          .borderRadius(50)
          .backgroundColor(Color.White)
          .width('85%')
          .margin({ top: 10 })
        }

      }, (event: EventModell) => event.title)
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Black)
  }
}

interface EventModel {
  id: number
  title: string
  location: string
  startTime: string
  endTime: string
  reminder: string
}
