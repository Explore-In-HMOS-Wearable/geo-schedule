import { NavigationService } from "../services/NavigationService"
import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStyleMode } from "@ohos.arkui.advanced.ArcButton"
import { BusinessError } from "@kit.BasicServicesKit"
import { calendarManager } from "@kit.CalendarKit"
import { calendarMgr } from "../entryability/EntryAbility"
import { EventModell } from "../model/EventModel"
import { LocationModel } from "../model/LocationModel"
import { promptAction } from "@kit.ArkUI"

@Entry
@Component
export struct NewEventPage {
  @State title: string = ""
  @State startTime: number = 0
  @State endTime: number = 0
  @State location: string = ""
  @State showDatePicker: boolean = false
  @State showTimePicker: boolean = false
  @State event: string = ""
  @State eventList: EventModell[] = []
  @StorageLink('location') currentLocation: LocationModel = new LocationModel();
  navigationService: NavigationService = NavigationService.getInstance();

  aboutToAppear(): void {
    console.info(`Succeeded in adding event, id -> ${this.currentLocation.name}`);
  }

  createEvent(): void {
    const date = new Date();

    this.startTime = date.getTime()
    this.endTime = date.getTime() + 60 * 60 * 1000

    let eventId: number | undefined = undefined;

    const event: calendarManager.Event = {
      title: this.title,
      type: calendarManager.EventType.NORMAL,
      startTime: this.startTime,
      endTime: this.endTime,
      // A 10-minute-countdown reminder before the start time.
      reminderTime: [10],
      location: {
        location: "",
        latitude: 0,
        longitude: 0
      }
    };
    let calendar: calendarManager.Calendar | undefined = undefined;
    const calendarAccount: calendarManager.CalendarAccount = {
      name: 'MyCalendar',
      type: calendarManager.CalendarType.LOCAL,
      displayName: 'MyCalendar'
    };

    const config: calendarManager.CalendarConfig = {
      enableReminder: true,
      color: '#aabbcc'
    };

    calendarMgr?.createCalendar(calendarAccount).then((data: calendarManager.Calendar) => {
      console.info(`Succeeded in creating calendar data->${JSON.stringify(data)}`);
      calendar = data;

      calendar.setConfig(config).then(() => {
        console.info(`Succeeded in setting config, data->${JSON.stringify(config)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to set config. Code: ${err.code}, message: ${err.message}`);
      });

      calendar.addEvent(event).then((data: number) => {
        console.info(`Succeeded in adding event, id -> ${data}`);
        eventId = data;
        this.eventList.push(new EventModell(this.title, this.startTime, this.endTime, "Reminder", this.currentLocation))
        AppStorage.setOrCreate('eventList', this.eventList);
        console.info(`Succeeded in adding event, id2 -> ${this.eventList[0].title}`);
        promptAction.showToast({ message: `Event created!` });
        this.navigationService.pageInfos.pushPath({ name: 'MainPage' })

      }).catch((err: BusinessError) => {
        console.error(`Failed to addEvent. Code: ${err.code}, message: ${err.message}`);
      });

    }).catch((error: BusinessError) => {
      console.error(`Failed to create calendar. Code: ${error.code}, message: ${error.message}`);
    });
  }

  build() {
    Column({ space: 12 }) {
      Image($r('app.media.back'))
        .width(20)
        .onClick(() => {
          this.navigationService.pageInfos.pushPath({ name: 'MainPage' })
        })
        .margin({ top: 30 })

      TextInput({ placeholder: "Event Title" })
        .onChange(v => this.title = v)
        .width("90%")
        .height(35)
        .fontSize(14)
        .placeholderFont({ size: 14 })

      Button("📍Choose Location")
        .onClick(() => {
          this.navigationService.pageInfos.pushPath({ name: 'LocationPage' })
        })
        .height(35)
        .width("90%")
        .backgroundColor(Color.White)
        .fontSize(14)
        .fontColor(Color.Black)

      ArcButton({
        options: new ArcButtonOptions({
          label: 'Save',
          position: ArcButtonPosition.BOTTOM_EDGE,
          styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
          onClick: () => {
            if (!this.title.trim()) {
              console.warn("Please enter a correct value!");
              promptAction.showToast({ message: `Please enter a correct value!` });
              return;
            }
            if (this.currentLocation.name == '') {
              console.warn("Please select your location!");
              promptAction.showToast({ message: `Please select your location!` });
              return;
            }
            this.createEvent()
          }
        })
      })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.Black)

  }
}