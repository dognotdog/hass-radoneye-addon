# Home Assistant RadonEye Addon

## About

This addon spawns a process that polls available nearby Ecosense RadonEye
devices over bluetooth and then publishes metrics to mqtt broker with home
assistant auto discovery.

## Requirements

Bluetooth adapter (accessed using dbus).

## Supported Devices

Currently addon supports only v2 version of Ecosense RadonEye device.

Support for v1 device can be added but volounteer with v1 device is needed to
test the change on https://github.com/sormy/radoneye-reader level.

## Installation

1. Ensure you have bluetooth adapter in Home Assistant setup.
2. Enable "Mosquitto broker" addon and enable MQTT integration in Home
   Assistant.
3. Create MQTT user with password in "Mosquitto broker" addon (Options/Logins):
   ```yaml
   - username: radoneye
     password: secret
   ```
4. Follow standard procedure https://www.home-assistant.io/addons/ and add this
   plugin by URL https://github.com/sormy/hass-radoneye-addon
5. Set username/password in RadonEye addon configuration.
6. Start addon.
7. Devices nearby must appear in Home Assistant.

For more detailed RadonEye configuration and default values please refer to
https://github.com/sormy/radoneye-reader documentation.

## Troubleshooting

You might need to disable Bluetooth integration if it interfer with RadonEye
addon work.

## License

MIT
