import {
	abilityAccessCtrl,
	AbilityConstant, common, ConfigurationConstant,
	PermissionRequestResult,
	Permissions, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { calendarManager } from '@kit.CalendarKit';
import { BusinessError } from '@kit.BasicServicesKit';

const DOMAIN = 0x0000;
export let calendarMgr: calendarManager.CalendarManager | null = null;
export let mContext: common.UIAbilityContext | null = null;

export default class EntryAbility extends UIAbility {
	onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
		this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
		hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
	}

	onDestroy(): void {
		hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
	}

	onWindowStageCreate(windowStage: window.WindowStage): void {
		// Main window is created, set main page for this ability
		hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

		windowStage.loadContent('pages/Index', (err) => {
			if (err.code) {
				hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
				return;
			}
			hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
		});

		mContext = this.context;
		const permissions: Permissions[] = ['ohos.permission.READ_CALENDAR', 'ohos.permission.WRITE_CALENDAR', 'ohos.permission.LOCATION' , 'ohos.permission.APPROXIMATELY_LOCATION'];
		let atManager = abilityAccessCtrl.createAtManager();
		atManager.requestPermissionsFromUser(mContext, permissions).then((result: PermissionRequestResult) => {
			console.info(`get Permission success, result: ${JSON.stringify(result)}`);
			calendarMgr = calendarManager.getCalendarManager(mContext);
		}).catch((error: BusinessError) => {
			console.error(`get Permission error, error. Code: ${error.code}, message: ${error.message}`);
		})
	}

	onWindowStageDestroy(): void {
		// Main window is destroyed, release UI related resources
		hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
	}

	onForeground(): void {
		// Ability has brought to foreground
		hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
	}

	onBackground(): void {
		// Ability has back to background
		hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
	}
}