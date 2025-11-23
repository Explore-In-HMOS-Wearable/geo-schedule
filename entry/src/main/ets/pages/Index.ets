import { calendarManager } from '@kit.CalendarKit';
import { calendarMgr } from '../entryability/EntryAbility';
import { BusinessError } from '@kit.BasicServicesKit';
import { NewEventPage } from './EventPage';
import { LocationPage } from './LocationPage';
import { NavigationService } from '../services/NavigationService';
import { MainPage } from './MainPage';
import { CalendarPage } from './CalendarPage';


@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear(): void {

    let eventId: number | undefined = undefined;
    const date = new Date();
    const event: calendarManager.Event = {
      title: 'title',
      type: calendarManager.EventType.NORMAL,
      startTime: date.getTime(),
      endTime: date.getTime() + 60 * 60 * 1000,
      // A 10-minute-countdown reminder before the start time.
      reminderTime: [10],
      location: {
        location: '',
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
      }).catch((err: BusinessError) => {
        console.error(`Failed to addEvent. Code: ${err.code}, message: ${err.message}`);
      });

    }).catch((error: BusinessError) => {
      console.error(`Failed to create calendar. Code: ${error.code}, message: ${error.message}`);
    });
  }

  navigationService: NavigationService = NavigationService.getInstance();

  @Builder
  routeMap(name: string) {
    NavDestination() {
      if (name === 'EventPage') {
        NewEventPage();
      } else if (name === 'LocationPage') {
        LocationPage();
      } else if (name === 'MainPage') {
        MainPage();
      } else if (name === 'CalendarPage') {
        CalendarPage();
      }
    }
    .onBackPressed(() => true)
    .hideTitleBar(true)
  }

  build() {
    Navigation(this.navigationService.pageInfos) {
      MainPage()
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.routeMap)
    .backgroundColor(Color.Black)
    .ignoreLayoutSafeArea()
    .hideTitleBar(true)
    .width('100%')
    .height('100%')
  }
}