# Simeon Baseline

## Azure > Resource groups
*AzureManagement/MicrosoftResources/ResourceGroups*

### **Baseline - m365alertsactiongroup**
#### **What does this do?**

Creates an Azure Monitor Action group to notify specified users of an alert. The baseline includes alerting the email address 'alerts@yourtenantname.com.' 

#### **Why should you use this?**

This keeps your tenant secure by immediately notifying you of suspicious activity.

#### **What is the end-user impact?**

N/A

#### **Learn more**

[Create and manage action groups in the Azure portal](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/action-groups)

### **Baseline - m365logging**
#### **What does this do?**

Creates an Azure Event Hub, Azure Log Analytics Workspace, and Azure Storage account to capture Azure and Intune logs. The baseline Workspace is named 'tenant Name-M365logging.'

#### **Why should you use this?**

This provides the essential resources required to capture logs, analyze trends, and be alerted of suspicious events.

#### **What is the end-user impact?**

N/A

#### **Learn more**

[Designing your Azure Monitor Logs deployment](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/design-logs-deployment)

## Azure AD > Company branding
*AadIam/CompanyBrandings*

### **Default**
#### **What does this do?**

Defines the messages and logos shown to users on Azure login screens. The baseline automatically populates the username watermark with 'user@yourcompanyname.org.' 

#### **Why should you use this?**

If you want to provide your users with a personalized login screen for added security, familiarity and branding.

#### **What is the end-user impact?**

Users will see the watermark (username hint) on Azure login screens.  

#### **Learn more**

[Customize your Azure AD sign-in page](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/customize-branding)

## Azure AD > Device settings
*AadIam/DeviceSettings*

### **Configuration**
#### **What does this do?**

Configures settings that control joining devices to Azure AD. The baseline allows only the groups 'Baseline - Device Enrollers' and 'Baseline - Microsoft 365 Users' to join up to 100 devices to Azure AD, as well as requires MFA.

#### **Why should you use this?**

To restrict the ability to join devices to Azure AD to only authorized groups and require MFA.

#### **What is the end-user impact?**

Only specified users may join devices, and those users will be prompted for MFA to join.

#### **Learn more**

N/A

## Azure AD > Diagnostic settings
*AzureManagement/MicrosoftAadIam/DiagnosticSettings*

### **Baseline - Logging**
#### **What does this do?**

Configures logging to capture Azure sign-in events, which can then be analyzed using Log Analytics Workspaces. The baseline captures all audit logs as well as all sign-in attempts. Logs can be viewed in the Analytics Workspace named 'tenant Name-M365logging' and are stored in the Azure Storage Account named 'tenantNameM365Logging.'

#### **Why should you use this?**

Increases security by providing you with the data needed to monitor and be alerted of log-in activity within your tenant.

#### **What is the end-user impact?**

N/A

#### **Learn more**

[Analyze Azure AD activity logs with Azure Monitor logs](https://docs.microsoft.com/en-us/azure/active-directory/reports-monitoring/howto-analyze-activity-logs-log-analytics)

## Azure AD > Directory settings
*MSGraph/Settings*

### **Group.Unified**
#### **What does this do?**

Configures restrictions for creating Azure AD Groups. The baseline restricts users not in 'Group Creators' from creating groups. 

#### **Why should you use this?**

If you want to tighten security around group creation, including naming conventions. 

#### **What is the end-user impact?**

User who are not in 'Group Creators' will be restricted from creating Azure AD groups. 

#### **Learn more**

[Manage who can create Microsoft 365 Groups](https://docs.microsoft.com/en-us/microsoft-365/solutions/manage-creation-of-groups?view=o365-worldwide)

## Azure AD > External user directory settings
*AadIam/ExternalUserDirectorySettings*

### **Configuration**
 #### **What does this do?**

Defines external collaborator settings including who can invite external collaborators and whether restrictions will be placed on external users. The baseline allows only authorized users with the 'Guest Inviter' role to invite external users.

#### **Why should you use this?**

The Azure default allows all users and guests to invite external users, so we recommend using the baseline setting to increase security. 

#### **What is the end-user impact?**

Users will not be able to invite external collaborators unless authorized.

#### **Learn more**

[Configure B2B external collaboration settings](https://docs.microsoft.com/en-us/azure/active-directory/external-identities/delegate-invitations)

## Azure AD > External user guest settings
*AadIam/ExternalUserGuestSettings*

### **Configuration**
#### **What does this do?**
Defines settings for permissions that guests users have in the tenant and to which external tenants guest invitations may be sent. The baseline preserves the Microsoft default settings, which allow invitations to be sent to any domain and restrict the permissions of guest users. 

#### **Why should you use this?**
If you want to apply Microsoft's default security settings for guest users, which increases security.. 

#### **What is the end-user impact?**
Authorized users may send invitations to any domain, but guest user permissions are restricted. 

#### **Learn more**
[Configure B2B external collaboration settings](https://docs.microsoft.com/en-us/azure/active-directory/external-identities/delegate-invitations#to-configure-external-collaboration-settings)

## Azure AD > Group settings
*AadIam/GroupSettings*

### **Configuration**
#### **What does this do?**

Configures group membership management options. The baseline does not allow group owners to approve requests, does not allow security group creation, and restricts users from seeing group membership.

#### **Why should you use this?**

If you want to have a more secure group settings environment. 

#### **What is the end-user impact?**

Owners cannot approve requests, security groups cannot be created, and users cannot see group membership.

#### **Learn more**

[Users, groups, and roles](https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/groups-self-service-management)

## Azure AD > Groups
*MSGraph/Groups*

### **Baseline - Autopilot Devices - Self Deploying**
#### **What does this do?**

Creates a dynamic device group that is used for assigning self-deploying Intune Autopilot profiles to devices. This group contains corporate physical devices with the tag 'Autopilot-SelfDeploying.' Devices can be tagged from the Intune portal or via an automated hardware hash upload. To tag in Intune go to Devices > Windows Enrollment > Devices, then select the required device and add to the 'Group Tag' field to tag via automated hardware hash included with column OrderId. 

#### **Why should you use this?**

If you want devices to be assigned the self-deployment Autopilot profile for device enrollment.

#### **What is the end-user impact?**

A device can be enrolled to Intune without end-user input.

#### **Learn more**

[Windows Autopilot Self-Deploying mode](https://docs.microsoft.com/en-us/mem/autopilot/self-deploying)

### **Baseline - Autopilot Devices - User Driven**
#### **What does this do?**

Creates a dynamic device group for assigning user-driven Autopilot profiles to devices. This group includes all devices that are not in the Azure AD group 'Autopilot Devices - Self Deploying.'

#### **Why should you use this?**

When a device is going to be used by a single user, this approach is ideal because the device shows as assigned in all relevant Intune pages and reports. It is also the most stable and consistent Autopilot mode.

#### **What is the end-user impact?**

Devices with this profile can be enrolled by users themselves. The device will be registered to the user and the user will be able to use the company portal application. 

#### **Learn more**

[Windows Autopilot User-Driven mode](https://docs.microsoft.com/en-us/mem/autopilot/user-driven)

### **Baseline - Corporate Devices - Insiders**
#### **What does this do?**

Creates a manually assigned device group for testing policies and applications assigned to 'Insiders.' Devices manually assigned to this group will be assigned to the 'Insiders' Windows update ring.

#### **Why should you use this?**

If you want to test Windows updates, application installs, and policies with the 'Insiders' group. Devices in this group will be the first to receive and test Windows updates.

#### **What is the end-user impact?**

Users of this group will be able to test application installs, policies and Windows updates before other users.

#### **Learn more**

N/A

### **Baseline - Corporate Devices - Physical**
#### **What does this do?**

Creates a group that includes only physical corporate devices managed by Intune.

#### **Why should you use this?**

This group is used to assign applications and policies that should apply to only physical devices (e.g. BitLocker encryption).

#### **What is the end-user impact?**

Users of this group can be assigned applications and policies that should apply to all physical devices. 

#### **Learn more**

N/A

### **Baseline - Corporate Devices - Preview**
#### **What does this do?**

Creates a manually assigned device group for previewing and testing policies and applications. Devices manually in this group will be assigned to the 'Preview Windows' update ring.

#### **Why should you use this?**

If you want to test Windows updates, application installs, and policies with the 'Preview Windows" device group in your environment. 

#### **What is the end-user impact?**

User devices in this group will be able to test Windows Updates, application installs, and policies separately from other users.

#### **Learn more**

N/A

### **Baseline - Corporate Devices - Virtual**
#### **What does this do?**

Creates a group that includes virtual corporate devices managed by Intune.

#### **Why should you use this?**

This group is used to assign applications and policies that should apply to all virtual devices managed by Intune.

#### **What is the end-user impact?**

Virtual user devices will be assigned applications and policies that should apply only to virtual devices. 

#### **Learn more**

N/A

### **Baseline - Corporate Devices**
#### **What does this do?**

Creates a group that includes all corporate devices regardless if they are virtual, physical or virtual desktops.  

#### **Why should you use this?**

This group can be used to assign applications and policies that should apply to all devices.

#### **What is the end-user impact?**

User devices in this group will be assigned all applications and policies. 

#### **Learn more**

N/A

### **Baseline - Device Administrators**
#### **What does this do?**

Creates a group of users assigned as local administrators on Azure AD joined devices. The baseline grants users in this group the Azure AD role 'Device Administrators.'

#### **Why should you use this?**

If you want to have a group of users with local administrator permissions on Azure AD joined devices, e.g. system administrators. 

#### **What is the end-user impact?**

Members in this group will have administrator access to an end-user's device.

#### **Learn more**

[Device Administrators Role](https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/directory-assign-admin-roles#device-administrators)

### **Baseline - Device Enrollers**
#### **What does this do?**

Creates a group of users that have permission to enroll a device that is not registered with Autopilot. If a user is not a member of this group, they cannot enroll a non-autopilot device.

#### **Why should you use this?**

If you want less restrictions for certain users to be able to enroll new devices into your environment that have not been pre-registered by uploading the device hardware hash.

#### **What is the end-user impact?**

Certain users will be able to have devices enrolled that were not Autopiloted.

#### **Learn more**

N/A

### **Baseline - Group Creators**
#### **What does this do?**

Configures restrictions for creating Microsoft 365 groups. The baseline restricts users not in this group from creating Microsoft 365 groups.

#### **Why should you use this?**

If you want to tighten security around Microsoft 365 group creation. 

#### **What is the end-user impact?**

Users who are not in this group will be restricted from creating Microsoft 365 groups. 

#### **Learn more**

[Manage who can create Microsoft 365 Groups](https://docs.microsoft.com/en-us/microsoft-365/solutions/manage-creation-of-groups?view=o365-worldwide)

### **Baseline - Microsoft 365 Users - Insiders**
#### **What does this do?**

Creates a manually assigned group to which Microsoft 365 licenses are assigned and to which configurations can be deployed before other rings of users. The baseline does not assign this group to any configurations. It is provided as a convenience.

#### **Why should you use this?**

If you want to test configuration changes using release rings containing a subset of users before deploying to all users. 

#### **What is the end-user impact?**

Users of this group may receive and test configuration changes before others users. 

#### **Learn more**

N/A

### **Baseline - Microsoft 365 Users - Preview**
#### **What does this do?**

Creates a manually assigned group to which Microsoft 365 licenses are assigned and to which configurations can be deployed before other rings of users. The baseline does not assign this group to any configurations. It is provided as a convenience.

#### **Why should you use this?**

If you want to test configuration changes using release rings containing a subset of users before deploying to all users. 

#### **What is the end-user impact?**

Users of this group may receive and test configuration changes before others users. 

#### **Learn more**

N/A

### **Baseline - Microsoft 365 Users**
#### **What does this do?**

Creates a dynamic group that assigns Microsoft 365 licenses to users for EMS and O365 functionality. This group also controls policies that should be applied to all users (e.g. password reset). The baseline places users that have a department into this group. If a user does not require a license (e.g. service accounts or off-boarded users), the department should be removed for that user.

#### **Why should you use this?**

If you want to dynamically manage the user license assignment and policies directed at licensed users.

#### **What is the end-user impact?**

Users with a department will be assigned appropriate licenses. 

#### **Learn more**

[Assign licenses to users](https://docs.microsoft.com/en-us/microsoft-365/admin/manage/assign-licenses-to-users?view=o365-worldwide)

[Editing a user's department](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-users-profile-azure-portal)

### **Baseline - Unrestricted Access From Unmanaged Devices And Untrusted Locations**
#### **What does this do?**

Creates a group that is used to bypass conditional access and mobile application protection policies that ensure content is accessed only from trusted devices, locations, and applications. The 'Baseline - Global Admin' account is added to this group.

#### **Why should you use this?**

If you want to allow certain users (e.g. a CEO or IT support user) to access content with a lesser degree of content security than is applied by default (e.g. using a personal computer or the native iOS mail app which does not protect content).

#### **What is the end-user impact?**

Users in this group can use any device or application of their choosing to access Microsoft 365 resources without any content protection policies.

#### **Learn more**

[Only allow apps that support protection policies](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/app-based-conditional-access)

[Protecting content on personal devices using app protection policies](https://docs.microsoft.com/en-us/mem/intune/apps/app-protection-policy)

## Azure AD > Mobility (MDM and MAM)
*AadIam/MdmApplications*

### **Microsoft Intune Enrollment**
#### **What does this do?**

Enables the legacy version of Microsoft Intune, which is required in some tenants for Intune management.

#### **Why should you use this?**

If you have clients that require the legacy version of Microsoft Intune.

#### **What is the end-user impact?**

Users with legacy versions of Intune will be able to use Intune. 

#### **Learn more**

[Intune vs. Intune Enrollment](https://github.com/MicrosoftDocs/azure-docs/issues/27017)

### **Microsoft Intune**
What is it: #### **What does this do?**

Turns on the ability to manage a Windows device using Intune. This is a prerequisite for using Intune to manage devices. 

#### **Why should you use this?**

If you want to use Intune to manage devices.

#### **What is the end-user impact?**

Users will be able to manage devices (e.g. configure their machines) using Intune.  

#### **Learn more**

[MDM vs. MAM](https://techcommunity.microsoft.com/t5/microsoft-intune/mdm-vs-mam/m-p/90906)

## Azure AD > Password reset
*AadIam/PasswordResetPolicies*

### **Configuration**
What is it: #### **What does this do?**

Defines Azure's password reset policy and specifies the Azure AD groups to which it applies. This allows users to reset their passwords or unlock their Azure accounts. The baseline applies the password reset policy to members of the group 'Baseline - Microsoft 365 Users.'  

#### **Why should you use this?**

If you want users to use self-service password reset instead of contacting IT support. This improves password reset security because it requires that users reset their passwords only via Mobile application code (the authenticator app) or SMS.

#### **What is the end-user impact?**

Users can securely recover and reset their passwords.

#### **Learn more**

[How it works: Azure AD self-service password reset](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-sspr-howitworks)

## Azure AD > Security > Conditional Access > Policies
*MSGraph/ConditionalAccess/Policies*

### **Baseline - Block Legacy Apps**
#### **What does this do?**

Blocks legacy protocols (POP, SMTP, IMAP, and MAPI) which can be used to bypass security controls in your environment. This policy does not apply to users in the Azure AD group 'Baseline - Unrestricted Access From Unmanaged Devices And Untrusted Locations.'

#### **Why should you use this?**

Improves security by prohibiting users from bypassing security controls in your environment.

#### **What is the end-user impact?**

Users may not use legacy protocols (POP, SMTP, IMAP, and MAPI).

#### **Learn more**

[How to: Block legacy authentication to Azure AD with Conditional Access](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/block-legacy-authentication)

### **Baseline - Block Legacy Exchange ActiveSync**
#### **What does this do?**

Blocks Exchange ActiveSync, which disables native iOS and Android mail clients. The baseline blocks Exchange Active sync for all users except those in the Azure AD group 'Baseline - Unrestricted Access From Unmanaged Devices And Untrusted Locations.'

#### **Why should you use this?**

It is recommended to disable native mail applications since they do not provide the same level of security and functionality as Microsoft Outlook.

#### **What is the end-user impact?**

Users cannot use native mail applications except if specifically allowed.

#### **Learn more**

[Policy recommendations for securing email](https://docs.microsoft.com/en-us/microsoft-365/enterprise/secure-email-recommended-policies?view=o365-worldwide)

### **Baseline - Block Platforms Other than iOS or Android from Unmanaged Devices and Untrusted Locations**
#### **What does this do?**

Blocks platforms other than iOS and Android from devices that are off-network and not Intune-managed. The baseline assigns the policy to all users except those in the Azure AD group 'Baseline - Unrestricted Access From Unmanaged Devices And Untrusted Locations.' The policy also excludes applications listed in the config property 'AppsAllowedFromUntrustedLocations.' 

#### **Why should you use this?**

This policy helps protect your data by blocking authentication from untrusted devices and locations. Application protection policies on iOS and Android have been tested and verified to protect data.

#### **What is the end-user impact?**

Users are restricted to iOS and Android platforms for authenticating devices when connecting from untrusted devices and locations.

#### **Learn more**

[How you can protect app data](https://docs.microsoft.com/en-us/mem/intune/apps/app-protection-policy)

### **Baseline - Require Approved Client Apps from Unmanaged Devices and Untrusted Locations**
#### **What does this do?**

Allows only mobile applications (iOS and Android) that support applications protection policies (e.g. Outlook, SharePoint, OneDrive, Excel) to connect from off-network. The baseline assigns the policy to all users except those in the Azure AD group 'Baseline - Unrestricted Access From Unmanaged Devices And Untrusted Locations.' The policy is also assigned to all applications except those listed in the config property 'AppsAllowedFromUntrustedLocations.' These protection policies do not work from other device types. This policy works in conjunction with the policy 'Block Platforms Other than iOS or Android from Unmanaged Devices and Untrusted Locations' to restrict non-iOS and android platforms and unprotected applications. Intune-managed devices are still able to access data off network.

#### **Why should you use this?**

This policy helps protect your data. Application protection policies on iOS and Android have been tested and verified to protect data. 

#### **What is the end-user impact?**

Users may only connect from off-network via iOS and Android devices. 

#### **Learn more**

[How you can protect app data](https://docs.microsoft.com/en-us/mem/intune/apps/app-protection-policy)

### **Baseline - Require Compliant Device for Intune Enrollment**
#### **What does this do?**

Requires that a device be registered in Autopilot by uploading a hardware hash before it can be enrolled in Intune. To bypass this requirement, a user must be a member of the Azure AD group 'Baseline - Device Enrollers.'

#### **Why should you use this?**

This increases security by preventing unauthorized devices from being enrolled into your tenant. 

#### **What is the end-user impact?**

IT must register devices in Autopilot before a general user can enroll it.

#### **Learn more**

N/A

### **Baseline - Require MFA for Admins**
#### **What does this do?**

Requires that users with privileged administrator roles authenticate using MFA. The baseline includes all users except those with the Azure AD role 'Directory Synchronization Accounts.'

#### **Why should you use this?**

If you want to further protect your tenant by requiring MFA for accounts that have privileged access. 

#### **What is the end-user impact?**

Users with privileged access must authenticate using MFA for each log in. 

#### **Learn more**

[Protect your Microsoft 365 global administrator accounts](https://docs.microsoft.com/en-us/office365/enterprise/protect-your-global-administrator-accounts)

### **Baseline - Require MFA from Unmanaged Devices and Untrusted Locations**
#### **What does this do?**

Requires MFA when authenticating from a non-compliant device that is off-network. The baseline requires MFA from all users except those with the Azure AD role 'Directory Synchronization Accounts.'

#### **Why should you use this?**

This further protects your data by ensuring that a device connecting to your network is compliant. 

#### **What is the end-user impact?**

Users must authenticate using MFA when accessing Microsoft 365 data from a non-compliant, off-network device. 

#### **Learn more**

[How to: Require MFA for access from untrusted networks with Conditional Access](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/untrusted-networks)

## Azure AD > User feature preview settings
*AadIam/FeatureSettings*

### **Configuration**
#### **What does this do?**

Allows Azure updates to be applied first to a specified group of users before being applied to all users in the tenant. 

#### **Why should you use this?**

If you want to test Azure updates with a subset of users in your environment. The specified users will receive Azure updates before other users.

#### **What is the end-user impact?**

Specified users will be able to test Azure updates before other users.

#### **Learn more**

N/A

## Azure AD > User settings
*AadIam/UserSettings*

### **Configuration**
#### **What does this do?**

Enables additional controls for users in Azure. The baseline allows users to register new applications and access the Azure portal, but does not allow LinkedIn connectors.

#### **Why should you use this?**

If you want your users to be able to register new applications and access the Azure portal, but not share data with LinkedIn.

#### **What is the end-user impact?**

Users may register new applications and access the Azure portal, but not access their LinkedIn connections within Microsoft applications. 

#### **Learn more**

[Default user permissions](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/users-default-permissions#to-restrict-the-default-permissions-for-member-users)

## Azure AD > Users
*MSGraph/Users*

### **Baseline - Global Admin**
#### **What does this do?**

Creates a global administrator account. The baseline creates a global administrator account that does not require a Microsoft 365 license, and the password can be managed in the Azure Portal. 

#### **Why should you use this?**

IT can use this dedicated admin user to manage a tenant. 

#### **What is the end-user impact?**

N/A

#### **Learn more**

[Administrator role permissions in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/directory-assign-admin-roles#global-administrator--company-administrator)

## Intune > Apps
*MSGraph/DeviceAppManagement/MobileApps*

### **7-Zip**
7-Zip is a file archiver with a high compression ratio.

### **AnyDesk**
AnyDesk remote access for remote administration.

### **CMTrace**
CMTrace is one of the Configuration Manager tools. It allows you to view and monitor log files, including the following types: Log files in Configuration Manager or Client Component Manager (CCM) format, plain ASCII or Unicode text files, such as Windows Installer logs. The tool helps to analyze log files by highlighting, filtering, and error lookup.

### **Company Portal**
Microsoft Intune helps organizations manage access to corporate apps, data, and resources. Company Portal is the app that lets you, as an employee of your company, securely access those resources.

Before you can use this app, make sure your IT admin has set up your work account. Your company must also have a subscription to Microsoft Intune.

Company Portal helps simplify the tasks you need to do for work:

- Enroll your device to access corporate resources, including Office, email, and OneDrive for Business
- Sign in to corporate resources with company-issued certificates
- Reduce the number of times you need to sign in to corporate resources with single sign-on
- Browse and install approved business apps from your IT department or the Microsoft Store for Business
- View and manage your enrolled devices – and wipe them if they get lost or stolen
- Get help directly from your IT department through available contact information
 
A note about Intune: every organization has different access requirements, and will use Intune in ways that they determine will best manage their information. Some functionality might be unavailable in certain countries. If you have questions about how this app is being used within your organization, your company’s IT administrator should have those answers for you. Microsoft, your network provider, and your device’s manufacturer do not know how Intune will be used by your organization.

### **Microsoft .NET Framework 3.5**
Microsoft .NET Framework 3.5.

### **Microsoft Edge for Windows 10**
Microsoft Edge is the browser for business with modern and legacy web compatibility, new privacy features such as Tracking prevention, and built-in productivity tools such as enterprise-grade PDF support and access to Office and corporate search right from a new tab.

### **Microsoft Windows Virtual Desktop Client**
Microsoft Windows Virtual Desktop Client

### **Netflix**
Netflix has something for everyone. Watch TV shows and movies recommended just for you, including award-winning Netflix original series, movies, and documentaries. There’s even a safe watching experience just for kids with family-friendly entertainment.

Now on Windows, you can enjoy every detail of the world’s favorite shows in 4K Ultra HD on Netflix. Download many of your favorite series and movies with the simple click of the download button. You can watch while you’re on the go or without an Internet connection on your PC, tablet or laptop with Windows 10. 

How does Netflix work?
- Instantly watch TV shows and movies through thousands of internet-connected devices. You can play, pause, and resume watching, all without commercials.
- Netflix adds new content all the time. Browse titles or search for your favorites.
- The more you watch, the better Netflix gets at recommending TV shows and movies that you’ll love — just for you. 
- You can create up to five individual profiles within a single Netflix account. Profiles allow different members of your household to have their own personalized Netflix experience built around the movies and TV shows they enjoy. 

If you decide Netflix isn't for you - no problem. No contract, no cancellation fees, no commitment. Cancel online anytime.

By clicking INSTALL, you consent to the installation of the Netflix application and any updates or upgrades thereto.

### **Office 365**
Office 365

### **Shortcut Cleanup**
Cleans up duplicate desktop shortcuts (ending with - Copy.lnk).

### **Visual Studio Code**
Visual Studio Code is a source code editor developed by Microsoft for Windows, Linux and macOS. It includes support for debugging, embedded Git control, syntax highlighting, intelligent code completion, snippets, and code refactoring. This software is also usable as an advanced text editor.

### **Xbox Console Companion**
The Xbox app brings together your friends, games, and accomplishments across Xbox One and Windows 10 devices. The best multiplayer gaming just got better.

     • Join clubs – or create your own – where you can go to play and chat with friends and other gamers like you.
     • Find games with like-minded players by checking Looking for Group posts, or post one that fits your own objectives and play style.
     • Get instant access to chat, sharing, parties, Game DVR, and achievements across PC and Xbox One.
     • Keep track of your game clips and screenshots and download them straight to your Windows 10 PC.
     • Take the brakes off chat when you use a keyboard for messaging with friends on Xbox Live.
     • Stream your favorite games and entertainment from Xbox One to a Windows 10 PC while using your Xbox One controller.

     Disclaimer: Broadband internet required (ISP fees apply). Xbox Live features only available with supported games. Online multiplayer (including streaming with multiplayer) and some features of Game DVR on Xbox One require Xbox Live Gold subscription (sold separately). Stream to one device at a time.

## Intune > Apps > App configuration policies
*MSGraph/DeviceAppManagement/TargetedManagedAppConfigurations*

### **Baseline - Configure Policy Managed Client Apps on Unmanaged iOS Devices**
#### **What does this do?**

Configures the default behavior for application settings of managed applications on unmanaged iOS devices. The baseline expands the list of applications that are protected by Intune and data loss protection policies. See the Intune portal for the full list of applications included in the baseline.

#### **Why should you use this?**

If you want to improve your users' iOS mobile experience by expanding the list of protected applications. 

#### **What is the end-user impact?**

 If you want to expand the list of applications that can access organization data on iOS devices.

#### **Learn more**

[Add app configuration policies for managed apps without device enrollment](https://docs.microsoft.com/en-us/mem/intune/apps/app-configuration-policies-managed-app)

## Intune > Apps > App protection policies (Platform = Android)
*MSGraph/DeviceAppManagement/AndroidManagedAppProtections*

### **Baseline - Protect Policy Managed Client Apps on Unmanaged Android Devices**
#### **What does this do?**

Configures the default behavior for managed client applications on unmanaged Android devices. The baseline allows data to flow between protected applications, but prohibits users from copying or saving data outside of the application except for users in the Azure AD group 'Baseline - Unrestricted Access From Unmanaged Devices And Untrusted Locations.'

#### **Why should you use this?**

 If you want to protect users' personal Android devices by preventing organization data from leaving protected apps.

#### **What is the end-user impact?**

 Android device users cannot copy or save data outside of your managed client applications.

#### **Learn more**

[App protection policies overview](https://docs.microsoft.com/en-us/mem/intune/apps/app-protection-policy)

## Intune > Apps > App protection policies (Platform = iOS/iPadOS)
*MSGraph/DeviceAppManagement/IosManagedAppProtections*

### **Baseline - Protect Policy Managed Client Apps on Unmanaged iOS Devices**
#### **What does this do?**

Configures the default behavior for managed client apps on unmanaged iOS devices. The baseline allows data to flow between protected apps, but prohibits users from copying or saving data outside of the app except for users in the Azure AD group 'Baseline - Unrestricted Access From Unmanaged Devices And Untrusted Locations'. 

#### **Why should you use this?**

 If you want to protect your data on users' personal iOS devices by preventing organization data from leaving protected apps.

#### **What is the end-user impact?**

 iOS device users cannot copy or save data outside of your managed client apps. 

#### **Learn more**

[How you can protect app data](https://docs.microsoft.com/en-us/mem/intune/apps/app-protection-policy)

## Intune > Apps > App protection policies (Platform = Windows 10)
*MSGraph/DeviceAppManagement/WindowsInformationProtectionPolicies*

### **Baseline - Protect Policy Managed Client Apps on Unmanaged Windows Devices**
#### **What does this do?**

Configures the default behavior for managed client applications on unmanaged Windows devices. The baseline allows data to flow between protected applications, but prohibits users from copying or saving data outside of managed applications except for users in the Azure AD group 'Baseline - Unrestricted Access From Unmanaged Devices And Untrusted Locations'. The default list of protected applications are Microsoft applications that support application protection policies.

#### **Why should you use this?**

 If you want to protect your data on users' personal Windows devices by preventing organization data from leaving protected applications. 

#### **What is the end-user impact?**

 Windows device users cannot copy or save data outside of your managed client apps. 

#### **Learn more**

[How you can protect app data](https://docs.microsoft.com/en-us/mem/intune/apps/app-protection-policy)

## Intune > Devices > Compliance policies
*MSGraph/DeviceManagement/DeviceCompliancePolicies*

### **Baseline - Corporate Devices - Physical - Windows**
#### **What does this do?**

Defines the required state that a physical device must be in to be considered compliant and before it can access organization data. The baseline requires that a physical device has a number of security controls configured including BitLocker encryption and a Microsoft Defender ATP risk score of medium or less. Assignment is based on the Azure AD group 'Baseline - Corporate Devices – Physical'. This policy applies only to physical devices since some requirements such as BitLocker are not supported on virtual devices. 

#### **Why should you use this?**

This provides a layer of data protection for your Intune managed devices. 

#### **What is the end-user impact?**

Users may only access organization data if the device passes the compliance policy conditions.

#### **Learn more**

[Use compliance policies to set rules for devices you manage with Intune](https://docs.microsoft.com/en-us/mem/intune/protect/device-compliance-get-started)

### **Baseline - Corporate Devices - Windows**
#### **What does this do?**

Defines the required state that a device (both physical and virtual) must be in to be considered compliant before accessing an organization's data. The baseline requires that a device has Microsoft Defender Antimalware configured. This policy applies to all devices in the Azure AD group 'Baseline - Corporate Devices'.

#### **Why should you use this?**

This provides an additional layer of data protection for your Intune-managed devices, both physical and virtual. 

#### **What is the end-user impact?**

Users may access an organization's data only if the device has Microsoft Defender Antimalware configured. 

#### **Learn more**

[Use compliance policies to set rules for devices you manage with Intune](https://docs.microsoft.com/en-us/mem/intune/protect/device-compliance-get-started)

## Intune > Devices > Configuration profiles
*MSGraph/DeviceManagement/DeviceConfigurations*

### **Baseline - Functionality - Microsoft Store Limited to Private Store Only**
#### **What does this do?**

Limits applications available for download in the Microsoft Store via the 'Private Store' functionality. This policy allows you to restrict your users to only those applications that you deem necessary.  

#### **Why should you use this?**

If you want to limit the applications which users may download to those in your private store.

#### **What is the end-user impact?**

Users may only use apps that you deem necessary. 

#### **Learn more**

[Distribute apps using your private store](https://docs.microsoft.com/en-us/microsoft-store/distribute-apps-from-your-private-store)

### **Baseline - OS - Default Windows 10 Update Ring**
#### **What does this do?**

Defines the default Windows Update configuration for Intune-managed devices. The baseline delays feature updates for 30 days and quality updates for 14 days after released by Microsoft. Once the deferral period has expired for the device, users have 3 days to restart (if required). Unattended updates are only applied outside working hours of 5am to 10pm. The Windows Update configuration applies to all corporate devices except those in the 'Insiders' or 'Preview' update rings that will receive updates before they are released to all other corporates devices.

#### **Why should you use this?**

If you want to ensure that your devices are kept up-to-date with the latest Windows updates.

#### **What is the end-user impact?**

Corporate devices outside of the 'Insiders' or 'Preview' rings will receive Windows feature updates 30 days after being released and quality updates 14 days after being released by Microsoft.  

#### **Learn more**

[Tactical considerations for creating Windows deployment rings](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/tactical-considerations-for-creating-windows-deployment-rings/ba-p/746979)

### **Baseline - OS - Insiders Windows 10 Update Ring**
#### **What does this do?**

Creates a Windows Update configuration for Intune-managed devices in the 'Insiders' ring that receive updates before any other device in your tenant. The baseline delays feature and quality updates to 'Insiders' for 3 days after released by Microsoft. Once the deferral period has expired for the device, users have 3 days to restart (if required). Unattended updates will be applied outside the working hours of 5am to 10pm. This Windows Update configuration applies to users in the Azure AD group 'Baseline - Corporate Devices – Insiders'. 

#### **Why should you use this?**

A Windows update ring is the best way to ensure Windows updates are compatible in your environment. The 'Insider" ring is meant for users that are technical enough to understand when an update is applied and to let you know if that update caused problems.

#### **What is the end-user impact?**

Users in the 'Insiders' ring will receive feature and quality updates 3 days after being released by Microsoft.

#### **Learn more**

[Tactical considerations for creating Windows deployment rings](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/tactical-considerations-for-creating-windows-deployment-rings/ba-p/746979)

### **Baseline - OS - Local Autopilot Reset Enabled**
#### **What does this do?**

Enables local Autopilot Reset on Windows 10, which allows an Autopilot Reset to be initiated locally at the device itself. If you do not enable this, you can initiate a reset only from the Azure Portal. 

#### **Why should you use this?**

In the event that remote Autopilot Reset from the Azure Portal is not possible due to connectivity or other issues, a user may initiate an Autopilot Reset themselves to restore their device to a known good state.

#### **What is the end-user impact?**

Users may initiate an Autopilot Reset themselves, which can come in handy if Autopilot Reset from the Azure Portal is not possible.

#### **Learn more**

[Windows Autopilot Reset](https://docs.microsoft.com/en-us/windows/deployment/windows-autopilot/windows-autopilot-reset-local)

### **Baseline - OS - Preview Windows 10 Update Ring**
#### **What does this do?**

Creates a Windows Update configuration for Intune-managed devices in the 'Preview' ring, which receive updates after 'Insiders' but before devices with the default policy. The baseline delays feature and quality updates to the 'Preview' group for 7 days after released by Microsoft. Once the deferral period has expired for a device, users have 3 days to restart (if required). Unattended updates will only be applied outside working hours of 5am to 10pm. Applies to users in the Azure AD group 'Baseline - Corporate Devices – Preview'. 

#### **Why should you use this?**

A Windows update ring is the best way to ensure Windows updates are compatible in your environment by testing the update in rings of users.. 

#### **What is the end-user impact?**

Users in the 'Preview' ring will receive updates 7 days after being released by Microsoft and after Insiders, but before devices with the default policy. 

#### **Learn more**

[Tactical considerations for creating Windows deployment rings](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/tactical-considerations-for-creating-windows-deployment-rings/ba-p/746979)

### **Baseline - OS - RDP Enabled**
#### **What does this do?**

Enables Remote Desktop access to the device for users that are members of the 'Remote Desktop Users' local group. A separate configuration (Add-AuthenticatedUsersToRemoteDesktopUsers) adds the users to the 'Remote Desktop Users' group. 

#### **Why should you use this?**

 If you want to allow Remote Desktop access to the device.

#### **What is the end-user impact?**

Users in the 'Remote Desktop Users' local group will be able to connect to remote devices. 

#### **Learn more**

[Policy CSP - RemoteDesktopServices](https://docs.microsoft.com/en-us/windows/client-management/mdm/policy-csp-remotedesktopservices)

### **Baseline - Security - BitLocker Device Encryption Enabled**
#### **What does this do?**

Enables and configures BitLocker device encryption for physical devices. BitLocker requires a machine to have TPM 1.2 or later, which excludes older hardware and virtual machines. 

#### **Why should you use this?**

Device encryption is essential to protecting data on physical devices.

#### **What is the end-user impact?**

Data on users' hard drives are encrypted.

#### **Learn more**

[Overview of BitLocker Device Encryption in Windows 10](https://docs.microsoft.com/en-us/windows/security/information-protection/bitlocker/bitlocker-device-encryption-overview-windows-10)

### **Baseline - Security - IE Site-to-Zone Assignment**
#### **What does this do?**

Configures URLs to include in the browser's security zones. The baseline configures the Intranet zone to include necessary Microsoft URLs for Azure Active Directory Seamless Single Sign-On. To add or remove additional sites, update the config variable 'AllowSiteToZoneAssignmentList'. 

#### **Why should you use this?**

Improves your users' browsing experience by automatically logging in to sites secured by Azure AD. 

#### **What is the end-user impact?**

Users will be unable to configure URLs for browser security zones themselves.

#### **Learn more**

[Internet Explorer security zones registry entries for advanced users](https://support.microsoft.com/en-us/help/182569/internet-explorer-security-zones-registry-entries-for-advanced-users) 

[Azure Active Directory Seamless Single Sign-On](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-sso-quick-start)

### **Baseline - Security - NTLMv2 LAN Manager Authentication Level**
#### **What does this do?**

Configures the Windows LAN Manager Authentication Level to require NTLMv2. 

#### **Why should you use this?**

This is recommended by Microsoft to prevent the use of insecure protocols.  

#### **What is the end-user impact?**

Windows file sharing will not work with any devices that do not support NTLMv2.

#### **Learn more**

[Network security: LAN Manager authentication level](https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/network-security-lan-manager-authentication-level)

### **Baseline - Security - Password Reset Enabled**
#### **What does this do?**

Enables Azure AD users to reset their passwords from the Windows login screen.

#### **Why should you use this?**

If you want to allow users to reset their passwords from the Windows login screen.

#### **What is the end-user impact?**

Users may reset their passwords from the Windows login screen.

#### **Learn more**

[Enable Azure Active Directory self-service password reset at the Windows sign-in screen](https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-sspr-windows)

### **Baseline - Security - Personal Microsoft Accounts Blocked**
#### **What does this do?**

Disables the addition of personal Microsoft accounts to devices to ensure Data Loss Prevention. 

#### **Why should you use this?**

If you want to prevent users from adding personal Microsoft accounts to Windows, which would allow them to transfer data outside of your organization. 

#### **What is the end-user impact?**

Users cannot connect Windows to personal Microsoft accounts.

#### **Learn more**

[Microsoft accounts configuration](https://docs.microsoft.com/en-us/mem/intune/configuration/device-restrictions-windows-10#cloud-and-storage)

### **Baseline - Security - Simple Passwords Disabled**
#### **What does this do?**

Blocks simple passwords including picture passwords.

#### **Why should you use this?**

If you want to increase security by blocking simple passwords. 

#### **What is the end-user impact?**

Users are restricted from creating simple passwords. 

#### **Learn more**

[Eliminate bad passwords using Azure Active Directory Password Protection](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-password-ban-bad)

### **Baseline - UX - Microsoft Consumer Experience Disabled**
#### **What does this do?**

Disables Microsoft Consumer Experiences such as Start suggestions, Membership notifications, Post-OOBE app install and redirect tiles.

#### **Why should you use this?**

If you want to improve the user experience by eliminating non value-add notifications and suggestions. 

#### **What is the end-user impact?**

Users will not see these additional pop-ups, suggestions and notifications.

#### **Learn more**

[Policy CSP - Experience](https://docs.microsoft.com/en-us/windows/client-management/mdm/policy-csp-experience#experience-allowwindowsconsumerfeatures)

### **Baseline - UX - Windows First Run Animation Disabled**
#### **What does this do?**

Disables Windows First Run animation, which displays animation and marketing when a user first signs into Windows. 

#### **Why should you use this?**

If you want to eliminate marketing materials and non-essential animation during initial sign-in.

#### **What is the end-user impact?**

Users may have an improved experience when opting out of First Run Animation. 

#### **Learn more**

[Policy CSP - WindowsLogon](https://docs.microsoft.com/en-us/windows/client-management/mdm/policy-csp-windowslogon#windowslogon-enablefirstlogonanimation)

### **Baseline - UX - Windows Hello Disabled**
#### **What does this do?**

Disables Windows Hello, a biometric sign-in system for Windows 10 that uses a near infrared (IR) imaging camera or fingerprint reader instead of a password to identify users.

#### **Why should you use this?**

If you want to disable Windows Hello and instead use passwords which are more in line with industry best practices.  

#### **What is the end-user impact?**

Users will not be prompted to sign in with a biometric system.

#### **Learn more**

N/A

### **Baseline - UX - Windows Spotlight Disabled**
#### **What does this do?**

Disables Windows Spotlight, which displays tips and third party marketing materials on users' lock screen. 

#### **Why should you use this?**

If you want to eliminate marketing materials being displayed to users. 

#### **What is the end-user impact?**

Users will not receive third party marketing materials on the lock screen.

#### **Learn more**

[Configure Windows Spotlight on the lock screen](https://docs.microsoft.com/en-us/windows/configuration/windows-spotlight)

## Intune > Devices > Configuration profiles (Profile Type = Administrative Templates)
*MSGraph/DeviceManagement/GroupPolicyConfigurations*

### **Baseline - Functionality - Microsoft Edge Configuration**
#### **What does this do?**

Configures Microsoft Edge for all devices to automatically sign in to the browser and synchronize history and passwords. Also sets Google as the default search engine. 

#### **Why should you use this?**

If you want to create an optimal user experience for the new Chromium Edge browser.

#### **What is the end-user impact?**

Users' search history and passwords will be synchronized across devices.

#### **Learn more**

[Microsoft Edge Enterprise Sync](https://docs.microsoft.com/en-us/deployedge/microsoft-edge-enterprise-sync)

### **Baseline - Functionality - OneDrive Silent Configuration**
#### **What does this do?**

Automatically and silently configures OneDrive and enables the Files On Demand feature.

#### **Why should you use this?**

Allows users to store data in OneDrive and access it without downloading all OneDrive content to the computer.

#### **What is the end-user impact?**

The first time a user logs in to a device, OneDrive will automatically sign in. Upon first sign-in the user will be able to see all her files, but not all files need to be downloaded to the computer. Files stored in the cloud will have a cloud icon in the corner, whereas files stored locally will have a green checkmark. 

#### **Learn more**

[Sync files with OneDrive Files on Demand](https://support.microsoft.com/en-us/office/sync-files-with-onedrive-files-on-demand-62e8d748-7877-420f-b600-24b56562aa70)

### **Baseline - Functionality - Windows Known Folders Move to OneDrive**
#### **What does this do?**

Configures OneDrive's Known Folders Move, which moves the directories Desktop, Documents, and Pictures to OneDrive and disables the option to opt out of the feature.

#### **Why should you use this?**

When configured this way, OneDrive backs up user data and enables access from any device.

#### **What is the end-user impact?**

Users may continue using familiar folders while being backed up. 

#### **Learn more**

[Redirect and move Windows known folders to OneDrive](https://docs.microsoft.com/en-us/onedrive/redirect-known-folders)

### **Baseline - OS - System Sleep Timeouts**
#### **What does this do?**

Sets the system sleep timeout for devices to 'Never' when plugged in.

#### **Why should you use this?**

If you want to prevent desktop computers from going to sleep so you can connect remotely at any time.

#### **What is the end-user impact?**

Users' devices will not go to sleep when plugged in, so users may connect remotely at any time.

#### **Learn more**

N/A



### **Baseline - Security - LinkedIn Features in Office Applications Disabled**
#### **What does this do?**

The baseline turns off LinkedIn features in Office applications. By default, this setting is turned on.  

#### **Why should you use this?**

You can turn off Office LinkedIn features so that your users are not sharing data externally with LinkedIn. 

#### **What is the end-user impact?**

Users will not be able to use the LinkedIn Office features. 

#### **Learn more**

[Integrate LinkedIn account connections in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/linkedin-integration)

## Intune > Devices > Enrollment restrictions
*MSGraph/DeviceManagement/DeviceEnrollmentConfigurations*

### **Baseline - deviceEnrollmentPlatformRestrictionsConfiguration - Device Enrollers can enroll personal devices**
#### **What does this do?**

Allows for specifying users that can enroll devices to Intune. The baseline allows users in the Azure AD group 'Baseline – Device Enrollers' to enroll any Windows device, and allows all other users to only enroll devices that have been previously registered with Autopilot. This limit can be overridden by other configurations with a higher priority.

#### **Why should you use this?**

If you want to restrict general users from enrolling personal Windows devices without Autopilot.

#### **What is the end-user impact?**

Only certain users will be able to enroll devices to Intune.

#### **Learn more**

[Set enrollment restrictions](https://docs.microsoft.com/en-us/mem/intune/enrollment/enrollment-restrictions-set)

### **deviceEnrollmentLimitConfiguration - All users and all devices**
#### **What does this do?**

Limits the default number of devices that a single user can enroll. The baseline sets this limit to 5, however it can be overwritten by other configurations with a higher priority.

#### **Why should you use this?**

If you want to ensure that no more than 5 devices are enrolled by a single user to prevent enrollment of unwanted devices. 

#### **What is the end-user impact?**

Users will be limited to enrolling 5 devices.

#### **Learn more**

[Create a device limit restriction](https://docs.microsoft.com/en-us/mem/intune/enrollment/enrollment-restrictions-set#create-a-device-limit-restriction)

### **deviceEnrollmentPlatformRestrictionsConfiguration - All users and all devices**
#### **What does this do?**

Restricts the type of device that can be enrolled. The baseline allows enrollment of all corporate devices and blocks all personal devices. This limit can be overridden by other configurations with a higher priority.

#### **Why should you use this?**

If you want to ensure that only corporate devices are enrolled in Intune.

#### **What is the end-user impact?**

Users will be restricted to enrolling corporate devices only in Intune.

#### **Learn more**

[Create a device type restriction](https://docs.microsoft.com/en-us/mem/intune/enrollment/enrollment-restrictions-set#create-a-device-type-restriction)

### **deviceEnrollmentWindowsHelloForBusinessConfiguration - All users and all devices**
#### **What does this do?**

The baseline disables Windows Hello for Business. 

#### **Why should you use this?**

If you do not want users to be prompted to setup Windows Hello the first time they log into a device.

#### **What is the end-user impact?**

Users will not be prompted to set up Windows Hello when they log in to a device for the first time.

#### **Learn more**

[Windows Hello for Business](https://docs.microsoft.com/en-us/mem/intune/protect/identity-protection-windows-settings)

### **windows10EnrollmentCompletionPageConfiguration - All users and all devices**
#### **What does this do?**

Configures the page that is displayed to users while a device enrollment is in progress. The baseline allows the user to select the 'Continue Anyway' option as soon as it is available and times out after 40 minutes.

#### **Why should you use this?**

If you want to allow users to click 'Continue Anyway' during the app installation phase of enrollment or when a single configuration in the enrollment process fails and you do not want users to get stuck indefinitely on the enrollment screen.

#### **What is the end-user impact?**

Users will be able to click 'Continue Anyway' when device enrollment enters the Device Enrollment phase as well as when a single configuration in the enrollment process fails.

#### **Learn more**

[Set up the Enrollment Status Page](https://docs.microsoft.com/en-us/mem/intune/enrollment/windows-enrollment-status)

## Intune > Devices > Scripts
*MSGraph/DeviceManagement/DeviceManagementScripts*

### **Baseline - Management - Set-IntuneManagementExtensionConfiguration**
#### **What does this do?**

The baseline configures the IntuneManagementExtension to not delete installation logs from devices. 

#### **Why should you use this?**

If you want to have logs available to troubleshoot device management issues.

#### **What is the end-user impact?**

Users will be able to view installation logs.

#### **Learn more**

N/A

### **Baseline - Management - Set-LocalAdminPassword**
#### **What does this do?**

Creates a local administrator account on Windows devices. This account password is set from the first three portions of the device's BitLocker recovery key (which can be viewed in the Azure portal) plus the letter "X" (e.g. 123456-123456-123456X)

#### **Why should you use this?**

IT Support personnel with permission to view the BitLocker recovery key will be able to log in to Windows devices using a local administrator account.

#### **What is the end-user impact?**

N/A

#### **Learn more**

[View BitLocker recovery keys](https://365adviser.com/azure/how-to-find-the-bitlocker-recovery-key-in-azure-ad)

### **Baseline - OS - Enable-TaskSchedulerHistory**
#### **What does this do?**

Enables the Windows Task Scheduler to display history of task runs. The baseline enables this setting and it is disabled by default.

#### **Why should you use this?**

This can help with troubleshooting scheduled tasks.

#### **What is the end-user impact?**

N/A

#### **Learn more**

[Enable Windows task scheduler history](https://medium.com/techygeekshome/enable-windows-task-scheduler-history-996a601a178c)

### **Baseline - OS - Set-TimeZone**
#### **What does this do?**

Configures Windows to set time zone automatically based on location. Also sets the default computer time zone based on public IP address, as some computers have issues using the Auto Time Zone Updater because of ISP or network restrictions.

#### **Why should you use this?**

If you want to automatically set the time zone based on location.

#### **What is the end-user impact?**

The time zone will be set automatically based on the device location.

#### **Learn more**

N/A

### **Baseline - Security - Add-AuthenticatedUsersToRemoteDesktopUsers**
#### **What does this do?**

Adds the Authenticated Users group to the Remote Desktop Users group so any authenticated user can connect via Remote Desktop. A separate configuration (OS - RDP Enabled) allows users in the 'Remote Desktop Users' group to access devices remotely. 

#### **Why should you use this?**

If you want to allow users to connect remotely via Remote Desktop.

#### **What is the end-user impact?**

Users may connect remotely via Remote Desktop.

#### **Learn more**

N/A

### **Baseline - Security - Disable-RdpNetworkLevelAuthentication**
#### **What does this do?**

Disables Network Level Authentication as a requirement for Remote Desktop. This is required to support clients that do not support Network Level Authentication. 

#### **Why should you use this?**

To allow connections via Remote Desktop from non-Azure AD joined devices. 

#### **What is the end-user impact?**

Users may connect remotely via Remote Desktop.

#### **Learn more**

It is not currently possible to use Network Level Authentication when using Remote Desktop to connect from a non-Azure AD joined device to an Azure AD joined device. Removing the requirement for Network Level Authentication will not prevent clients from trying to negotiate Network Level Authentication if they support it. That means that Windows clients that are not joined to the same Azure AD as the host must explicitly add 'enablecredsspsupport:i:0' in the .rdp file when connecting to prevent attempts to pre-authenticate.

## Intune > Devices > Windows Autopilot deployment profiles
*MSGraph/DeviceManagement/WindowsAutopilotDeploymentProfiles*

### **Baseline - Self Deploying Profile**
#### **What does this do?**

Creates an Intune autopilot profile for enrolling machines using the self-deploying method, which enables a device to be enrolled into your environment with little to no user interaction. Self-deployment mode comes with restrictions including that the device must have TPM 2.0, and it is not supported on virtual machines even if they have a virtual TPM. Devices in the Azure AD group 'Baseline - Autopilot Devices - Self Deploying' will be assigned this profile. 

#### **Why should you use this?**

This is most useful for devices that will be shared or used as a kiosk. If a device is going to be used by a single user it is best to use the user-driven method.

#### **What is the end-user impact?**

User devices assigned to this profile can be configured using the self-deployment method.

#### **Learn more**

[Windows Autopilot Self-Deploying mode](https://docs.microsoft.com/en-us/mem/autopilot/self-deploying)

### **Baseline - User Driven Profile**
#### **What does this do?**

Creates an Intune autopilot profile for enrolling machines using the user-driven method. Devices in the Azure AD group 'Autopilot Devices - User Driven' will be assigned this profile.

#### **Why should you use this?**

When a device is going to be used by a single user, this approach is ideal because the device shows as assigned in all relevant Intune pages and reports. It is also the most stable and consistent Autopilot mode.

#### **What is the end-user impact?**

Devices with this profile can be enrolled by users themselves. The device will be registered to the user and the user will be able to use the company portal application. 

#### **Learn more**

[Windows Autopilot user-driven mode](https://docs.microsoft.com/en-us/mem/autopilot/user-driven)

## Intune > Diagnostic settings
*AzureManagement/MicrosoftIntune/DiagnosticSettings*

### **Baseline - Logging**
#### **What does this do?**

Configures logging to capture Intune events, which can then be analyzed using Log Analytics Workspaces. The baseline captures device audit logs, compliance, and operational logs. Logs can be viewed in the Analytics Workspace named 'tenant Name-M365logging' and are stored in the Azure Storage Account named 'tenantNameM365Logging.'

#### **Why should you use this?**

You can set up alerts for when an Intune-managed device is marked non-compliant or when a new device is enrolled into the environment. This improves security by providing you with the data needed to monitor Intune events within your tenant. 

#### **What is the end-user impact?**

N/A

#### **Learn more**

[Microsoft Intune and Azure Log Analytics](https://techcommunity.microsoft.com/t5/device-management-in-microsoft/microsoft-intune-and-azure-log-analytics/ba-p/463145)

## Office 365 > Exchange > AdminAuditLogConfig
*PowerShell/Exchange/Organization/AdminAuditLogConfig*

### **Admin Audit Log Settings**
#### **What does this do?**

Configures Exchange logging so that IT users can search Exchange audit logs. The baseline turns on Exchange logging.

#### **Why should you use this?**

If you want to trace changes to the person who made the change, augment your change logs with detailed records of the change as it was implemented, comply with regulatory requirements and requests for discovery, as well as other tracing.

#### **What is the end-user impact?**

N/A

#### **Learn more**

[Turn audit log search on or off](https://docs.microsoft.com/en-us/microsoft-365/compliance/turn-audit-log-search-on-or-off?view=o365-worldwide#turn-on-audit-log-search)

## Office 365 > Exchange > OrganizationConfig
*PowerShell/Exchange/Organization/OrganizationConfig*

### **First Organization**
#### **What does this do?**

Defines various Exchange settings. Microsoft changes these settings frequently as features are added and removed.

#### **Why should you use this?**

If you want to track configuration changes made in the environment.

#### **What is the end-user impact?**

N/A

#### **Learn more**

[Set-OrganizationConfig](https://docs.microsoft.com/en-us/powershell/module/exchange/set-organizationconfig?view=exchange-ps)

## Office 365 > Exchange > Outlook Web App policies
*PowerShell/Exchange/ClientAccess/OwaMailboxPolicies*

### **OwaMailboxPolicy-Default**
#### **What does this do?**

Configures the default settings for Outlook on the web. The baseline uses the default configurations provided by Microsoft. 

#### **Why should you use this?**

If you want to use the default Outlook on the web policies.

#### **What is the end-user impact?**

N/A

#### **Learn more**

[OwaMailboxPolicy](https://docs.microsoft.com/en-us/powershell/module/exchange/set-owamailboxpolicy?view=exchange-ps)

## Office 365 > Security & Compliance > Information governance > Retention
*PowerShell/PolicyAndCompliance/Retention/RetentionCompliancePolicies*

### **Baseline - Default Retention Policy**
#### **What does this do?**

Defines the data retention policy for SharePoint, OneDrive and Exchange Online. The baseline retains this data for one year.

#### **Why should you use this?**

If you want this data to be retained for one year and to be searchable in Office 365 content search tools. 

#### **What is the end-user impact?**

Users cannot permanently delete data that is less than one year old. 

#### **Learn more**

[Retention policies and labels](https://docs.microsoft.com/en-us/microsoft-365/compliance/retention?view=o365-worldwide)

## Office 365 > Security & Compliance > Information governance > Retention (Teams)
*PowerShell/PolicyAndCompliance/Retention/TeamsRetentionCompliancePolicies*

### **Baseline - Teams Retention Policy**
#### **What does this do?**

Defines the data retention policy for Microsoft Teams. The baseline retains Teams data for one year.

#### **Why should you use this?**

If you want this data to be retained for one year and to be searchable in Office 365 content search tools. 

#### **What is the end-user impact?**

Users cannot permanently delete data that is less than one year old. 

#### **Learn more**

[Retention policies in Microsoft Teams](https://docs.microsoft.com/en-us/microsoftteams/retention-policies)

## Office 365 > Teams > Apps
*TeamsApi/Users/TenantWideAppsSettings*

### **Configuration**
#### **What does this do?**

Defines global settings for Microsoft Teams. The baseline allows users to add Teams apps in general, and another setting (TeamsAppPermissionPolicy) allows you to specify approved Teams applications. 

#### **Why should you use this?**

To allow users to add Teams apps.

#### **What is the end-user impact?**

Users will be able to add Teams apps. 

#### **Learn more**

[Manage Teams settings for your organization](https://docs.microsoft.com/en-us/microsoftteams/enable-features-office-365)

[Manage your apps in the Microsoft Teams admin center](https://docs.microsoft.com/en-us/microsoftteams/manage-apps)

## Office 365 > Teams > Apps > Permission policies
*TeamsPSAdmin/TeamsAppPermissionPolicy*

### **Global**
#### **What does this do?**

Allows admins to specify approved Teams applications. Another setting (TenantWideAppsSettings) allows for Teams applications in general to be used. 

#### **Why should you use this?**

If you want to be able to restrict users from using unapproved Teams apps. 

#### **What is the end-user impact?**

Users may use only those Teams apps allowed by admins. 

#### **Learn more**

[Manage app permission policies in Microsoft Teams](https://docs.microsoft.com/en-us/microsoftteams/teams-app-permission-policies)

## Office 365 > Teams > Org-wide settings
*TeamsPSAdmin/TeamsClientConfiguration*

### **Global**
#### **What does this do?**

Defines global settings for Microsoft Teams. The baseline blocks third party file sharing applications (e.g. Box, DropBox, Google Drive).

#### **Why should you use this?**

To prevent users from sharing company content externally. 

#### **What is the end-user impact?**

Users will not be able to share content outside of the organization using Microsoft Teams. 

#### **Learn more**

[Disable additional cloud storage (DropBox, Box and Google Drive)](https://techcommunity.microsoft.com/t5/microsoft-teams/disable-additional-cloud-storage-dropbox-box-and-google-drive/m-p/253335)
