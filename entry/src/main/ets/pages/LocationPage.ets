import { geoLocationManager } from '@kit.LocationKit';
import { BusinessError } from '@kit.BasicServicesKit'
import { LocationModel } from '../model/LocationModel';
import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStyleMode, PromptAction } from '@kit.ArkUI';
import { NavigationService } from '../services/NavigationService';

try {
  let locationEnabled = geoLocationManager.isLocationEnabled();
} catch (err) {
  console.error(`errCode: ${err.code}, message: ${err.message}`);
}

@Entry
@Component
export struct LocationPage {
  @State locations: LocationModel[] = [];
  @State nameInput: string = '';

  @State location: LocationModel = new LocationModel()

  navigationService: NavigationService = NavigationService.getInstance();

  private uiContext: UIContext = this.getUIContext()
  private promptAction: PromptAction = this.uiContext.getPromptAction()

  async addCurrentLocation(): Promise<void> {
    if (!this.nameInput.trim()) {
      console.warn('Please enter a correct value!');
      this.promptAction.showToast({ message: `Please enter a correct value!` });
      return;
    }

    let request: geoLocationManager.SingleLocationRequest = {
      'locatingPriority': geoLocationManager.LocatingPriority.PRIORITY_LOCATING_SPEED,
      'locatingTimeoutMs': 10000
    }

    try {
      await geoLocationManager.getCurrentLocation(request).then((result) => {
        console.info(`Current location: ${JSON.stringify(result)}`);
        this.promptAction.showToast({ message: `Current Loc Latitude: ${JSON.stringify(result.latitude)}` });

        this.locations.push(new LocationModel(
          this.nameInput,
          result.latitude,
          result.longitude
        )
        );
        this.location = new LocationModel(this.nameInput, result.latitude, result.longitude)
        AppStorage.setOrCreate('location', this.location);

        this.nameInput = '';

        console.info('Current locations list:');
        this.locations.forEach((loc, index) => {
          console.info(`${index + 1}. ${loc.name} -> Lat: ${loc.latitude}, Lng: ${loc.longitude}`);
          this.promptAction.showToast({ message: `${this.nameInput} added!` });
        });

        this.navigationService.pageInfos.pushPath({ name: 'EventPage' })
      }).catch((error: BusinessError) => {
        console.error(`getCurrentLocation error = ${JSON.stringify(error)}`);
        this.promptAction.showToast({ message: `${JSON.stringify(error)} error!` });
      });
    } catch (err) {
      console.error(`errCode: ${JSON.stringify(err)}`);
    }
  }

  build() {
    Column() {
      Image($r('app.media.back'))
        .width(20)
        .onClick(() => {
          this.navigationService.pageInfos.pushPath({ name: 'EventPage' })
        })
        .margin({ top: 30})

      Text('Set your current location!')
        .fontSize(14)

      TextInput({ placeholder: 'Enter location name' })
        .onChange(v => this.nameInput = v)
        .width('90%')
        .height(35)
        .fontSize(14)
        .placeholderFont({ size: 14 })

      ArcButton({
        options: new ArcButtonOptions({
          label: 'OK',
          position: ArcButtonPosition.BOTTOM_EDGE,
          styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
          onClick: () => {
            this.addCurrentLocation()
          }
        })
      })

    }.width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
