# Gateway
![](https://img.shields.io/badge/flutter_support-%3E%3D%202.8.0-blue) ![](https://img.shields.io/badge/angular-%3E%3D%2013-red) ![](https://img.shields.io/badge/Nodejs-%20-red) ![](https://img.shields.io/badge/esp32--arduino-%20%20-green) ![](https://img.shields.io/badge/gateway_build-0.4.3-green.svg) ![](https://img.shields.io/badge/bluetooth__low__engery-4--5-blue)![](https://img.shields.io/github/issues/GDSC-HSU/gateway) ![](https://img.shields.io/github/issues-closed/GDSC-HSU/gateway)

> Coronavirus can cause more severe symptoms in people with weakened immune systems, older people and those with long-term conditions like diabetes, cancer and chronic lung disease.

Gateway is an open-source solution for covid 19 situation. Ours goal is provide solution for those `4 major pillar` recommended by WHO.

*`WHO #include 4 major pillar`*

- **`0x1`**. Health Declaration (vaccinated) before enter, via QR code identification.

- **`0x2`**. Wearing facemask protect yourself and others.

- **`0x3`**. Hand sanitizer regularly.

- **`0x4`**. Fever temperature recognition.


`An quick introduce of ours scope - TLDR`**`picture`**`is worth a thousand words ⬇️`

---
![aaa](./docs/img/gateway_project_proposal.jpeg)

---

![bb](./docs/img/gateway_system_proposal.jpeg)

---

We've been in those situation and manual "Guidance & Prevenence" of coronavirus  and "Back to office" or coming back to normal. Manual we mean by we still have security

<p align=center style="background-color:whitesmoke; padding:10px"> <img src="https://img.shields.io/badge/ours--goal-cost--effected-critial"> <img src="https://img.shields.io/badge/open--source-techonlogy-red">

Within ours scope we define an "cost effected" "self-hostable" solution, ours goal is widespread this solution - with that in mind. We're aim to support this solution Documentation, [Wiki](https://github.com/GDSC-HSU/gateway/wiki/TEAM-DEVELOPMENT-SETUP) and configuration by doing so we could encourage learner in high school, collages students build up this solution by their own.

further detail are covered in this issue ref [link](https://github.com/GDSC-HSU/gateway/issues/11)

---
![aa](./docs/img/gateway_hmw_desgin_selft_host.jpeg)

---

Gateway in an application running in yours device  (ours supported architecture). It will communicate with gateway-devices with it wireless sensor over Bluetooth connection protocol. By combining application and IoT devices, we’re able enable an solution for covid-19 control and prevention.

---
![aa](./docs/img/gateway_techology_stack.jpeg)

---

We also `encourage undergraduate, learner, students` who might found interesting about “technical” aspect of the project, they could find by themselves having a `“proof of concept”` of how those technology work together in an ecosystem and better or `excel their STEM innovation`.




##### Supported architecture :
- Gateway : Mobile (Android, IOS), Web (coming soon), Google Cloud Platform.
- Gateway-devices: ESP32 BLE, Arduino framework.
- Google Cloud Platform : Infrastructure as code provisioning (backend, firebase) via [`terraform`](./gateway-core/tf/)



---
##### Project structure module

Project compose 4 git submodule

1. Mobile Application  [current directory](./)
2. IoT Embedded device [./ble_devices/](https://github.com/GDSC-HSU/gateway-devices)
3. Backend Infrastructure [./gateway-core](https://github.com/GDSC-HSU/gateway-core)
4. Web Configuration – Management Dashboard [./gateway-dashboard](https://github.com/GDSC-HSU/gateway-dashboard)



README.MD : are covered in each module for clearer explanation


---

#### Contributor:

<a href="https://github.com/GDSC-HSU/gateway/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=GDSC-HSU/gateway" />
</a>

Made with [contrib.rocks](https://contrib.rocks).