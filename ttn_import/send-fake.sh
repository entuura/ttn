#!/bin/sh

#curl --silent -H 'Content-type: application/json' --data '{"end_device_ids":{"device_id":"temp-and-humidity","application_ids":{"application_id":"salle-technique"},"dev_eui":"A84041853186F7FC","join_eui":"A000000000000100","dev_addr":"260BFC8D"},"correlation_ids":["gs:uplink:01HH7E2C0P4XYCNAP1FNCWXKED"],"received_at":"2023-12-09T14:00:30.179846004Z","uplink_message":{"session_key_id":"AYw52rHadSbIrMwG5fF5xg==","f_port":2,"f_cnt":294,"frm_payload":"zFMOTACbAQ5If/8=","decoded_payload":{"BatV":3.155,"Bat_status":3,"Ext_sensor":"Temperature Sensor","Hum_SHT":15.5,"TempC_DS":36.56,"TempC_SHT":36.6},"rx_metadata":[{"gateway_ids":{"gateway_id":"eui-a84041ffff269190","eui":"A84041FFFF269190"},"time":"2023-12-09T14:00:29.926522Z","timestamp":115195093,"rssi":-103,"channel_rssi":-103,"snr":11.8,"frequency_offset":"-202","uplink_token":"CiIKIAoUZXVpLWE4NDA0MWZmZmYyNjkxOTASCKhAQf//JpGQENX59jYaDAj95dGrBhCenOrQAyCIwKaRrfoC","channel_index":4,"received_at":"2023-12-09T14:00:29.871827960Z"}],"settings":{"data_rate":{"lora":{"bandwidth":125000,"spreading_factor":7,"coding_rate":"4/5"}},"frequency":"867300000","timestamp":115195093,"time":"2023-12-09T14:00:29.926522Z"},"received_at":"2023-12-09T14:00:29.975611975Z","consumed_airtime":"0.061696s","version_ids":{"brand_id":"dragino","model_id":"lht65","hardware_version":"_unknown_hw_version_","firmware_version":"1.9.1","band_id":"EU_863_870"},"network_ids":{"net_id":"000013","ns_id":"EC656E0000000181","tenant_id":"ttn","cluster_id":"eu1","cluster_address":"eu1.cloud.thethings.network"}}}' https://odoo.nella.org/ttn/uplink | jq

# For debugging uplinks with no version_ids
#curl --silent -H 'Content-type: application/json' --data '{"end_device_ids":{"device_id":"eui-a840414e0188d394","application_ids":{"application_id":"stevie-test-app-01"},"dev_eui":"A840414E0188D394","join_eui":"A840410000000101","dev_addr":"260BD2E8"},"correlation_ids":["gs:uplink:01HHY4VJ0AP7C83VEDM0YZRZ2B"],"received_at":"2023-12-18T09:42:01.688454316Z","uplink_message":{"session_key_id":"AYvaFVfpyadbIKifBi3kFg==","f_port":2,"f_cnt":2268,"frm_payload":"Dl1lgBV6AABOAkY=","decoded_payload":{"ADC_CH0V":5.498,"BatV":3.677,"Digital_IStatus":"L","Door_status":"OPEN","EXTI_Trigger":"FALSE","Hum_SHT":58.2,"TempC1":2598.4,"TempC_SHT":7.8,"Work_mode":"IIC"},"rx_metadata":[{"gateway_ids":{"gateway_id":"eui-00016c001f160f18","eui":"00016C001F160F18"},"time":"2023-12-18T10:26:44.814Z","timestamp":3168854626,"rssi":-38,"channel_rssi":-38,"snr":14,"frequency_offset":"-14008","location":{"latitude":46.46313,"longitude":6.23425,"altitude":726,"source":"SOURCE_REGISTRY"},"uplink_token":"CiIKIAoUZXVpLTAwMDE2YzAwMWYxNjBmMTgSCAABbAAfFg8YEOLEg+cLGgwI6aeArAYQ/LeT5gEg0J3R85y2YCoMCOS8gKwGEIDPkoQD","channel_index":7,"gps_time":"2023-12-18T10:26:44.814Z","received_at":"2023-12-18T09:42:01.482663420Z"}],"settings":{"data_rate":{"lora":{"bandwidth":125000,"spreading_factor":7,"coding_rate":"4/5"}},"frequency":"867900000","timestamp":3168854626,"time":"2023-12-18T10:26:44.814Z"},"received_at":"2023-12-18T09:42:01.483557389Z","consumed_airtime":"0.061696s","network_ids":{"net_id":"000013","ns_id":"EC656E0000000181","tenant_id":"ttn","cluster_id":"eu1","cluster_address":"eu1.cloud.thethings.network"}}}' \
# https://odoo.nella.org/ttn/uplink | jq

# For debugging a different version_ids
#echo '{"end_device_ids":{"device_id":"eui-a8404148f188d395","application_ids":{"application_id":"stevie-test-app-01"},"dev_eui":"A8404148F188D395","join_eui":"A840410000000101","dev_addr":"260B47EF"},"correlation_ids":["gs:uplink:01HKPN1SSMXHFMJPTCT5VE158R"],"received_at":"2024-01-09T08:22:31.682004556Z","uplink_message":{"session_key_id":"AYyO+Sg8B5umjmQHJEmuJw==","f_port":2,"f_cnt":1319,"frm_payload":"Dlf/5AAADADtf/8=","decoded_payload":{"ALARM_status":"FALSE","BatV":3.671,"Temp_Black":3276.7,"Temp_Red":-2.8,"Temp_White":23.7,"Work_mode":"DS18B20"},"rx_metadata":[{"gateway_ids":{"gateway_id":"eui-00016c001f160f18","eui":"00016C001F160F18"},"time":"2024-01-09T08:42:38.408Z","timestamp":1950249661,"rssi":-62,"channel_rssi":-62,"snr":13.2,"frequency_offset":"-12121","location":{"latitude":46.46313,"longitude":6.23425,"altitude":726,"source":"SOURCE_REGISTRY"},"uplink_token":"CiIKIAoUZXVpLTAwMDE2YzAwMWYxNjBmMTgSCAABbAAfFg8YEL3l+aEHGgwIx4T0rAYQr++H4wEgyOTAn+HPIioMCP6N9KwGEICsxsIB","gps_time":"2024-01-09T08:42:38.408Z","received_at":"2024-01-09T08:22:31.476182447Z"}],"settings":{"data_rate":{"lora":{"bandwidth":125000,"spreading_factor":7,"coding_rate":"4/5"}},"frequency":"868100000","timestamp":1950249661,"time":"2024-01-09T08:42:38.408Z"},"received_at":"2024-01-09T08:22:31.476869934Z","consumed_airtime":"0.061696s","locations":{"user":{"latitude":46.4631023,"longitude":6.23158,"altitude":753,"source":"SOURCE_REGISTRY"}},"network_ids":{"net_id":"000013","ns_id":"EC656E0000000181","tenant_id":"ttn","cluster_id":"eu1","cluster_address":"eu1.cloud.thethings.network"}}}' | jq
#curl --silent -H 'Content-type: application/json' --data '{"end_device_ids":{"device_id":"eui-a8404148f188d395","application_ids":{"application_id":"stevie-test-app-01"},"dev_eui":"A8404148F188D395","join_eui":"A840410000000101","dev_addr":"260B47EF"},"correlation_ids":["gs:uplink:01HKPN1SSMXHFMJPTCT5VE158R"],"received_at":"2024-01-09T08:22:31.682004556Z","uplink_message":{"session_key_id":"AYyO+Sg8B5umjmQHJEmuJw==","f_port":2,"f_cnt":1319,"frm_payload":"Dlf/5AAADADtf/8=","decoded_payload":{"ALARM_status":"FALSE","BatV":3.671,"Temp_Black":3276.7,"Temp_Red":-2.8,"Temp_White":23.7,"Work_mode":"DS18B20"},"rx_metadata":[{"gateway_ids":{"gateway_id":"eui-00016c001f160f18","eui":"00016C001F160F18"},"time":"2024-01-09T08:42:38.408Z","timestamp":1950249661,"rssi":-62,"channel_rssi":-62,"snr":13.2,"frequency_offset":"-12121","location":{"latitude":46.46313,"longitude":6.23425,"altitude":726,"source":"SOURCE_REGISTRY"},"uplink_token":"CiIKIAoUZXVpLTAwMDE2YzAwMWYxNjBmMTgSCAABbAAfFg8YEL3l+aEHGgwIx4T0rAYQr++H4wEgyOTAn+HPIioMCP6N9KwGEICsxsIB","gps_time":"2024-01-09T08:42:38.408Z","received_at":"2024-01-09T08:22:31.476182447Z"}],"settings":{"data_rate":{"lora":{"bandwidth":125000,"spreading_factor":7,"coding_rate":"4/5"}},"frequency":"868100000","timestamp":1950249661,"time":"2024-01-09T08:42:38.408Z"},"received_at":"2024-01-09T08:22:31.476869934Z","consumed_airtime":"0.061696s","locations":{"user":{"latitude":46.4631023,"longitude":6.23158,"altitude":753,"source":"SOURCE_REGISTRY"}},"network_ids":{"net_id":"000013","ns_id":"EC656E0000000181","tenant_id":"ttn","cluster_id":"eu1","cluster_address":"eu1.cloud.thethings.network"}}}' \
#    https://odoo.nella.org/ttn/uplink | jq

# another version_ids?
data='{"end_device_ids":{"device_id":"eui-a8404165d1881259","application_ids":{"application_id":"stevie-test-app-01"},"dev_eui":"A8404165D1881259","join_eui":"A840410000000100","dev_addr":"260B0D8E"},"correlation_ids":["gs:uplink:01HKPPR9RA3E1X1DK19A4CR9EY"],"received_at":"2024-01-09T08:52:17.497074135Z","uplink_message":{"session_key_id":"AYvYEAot8UCxAyBcpSgtyQ==","f_port":2,"f_cnt":7791,"frm_payload":"y63/AwMjBf//f/8=","decoded_payload":{"batState":"Good","batV_V":2.989,"intHum_pct":80.3,"intTemp_C":-2.53},"rx_metadata":[{"gateway_ids":{"gateway_id":"hepia-lecea-01","eui":"0016C001FF10DAF6"},"time":"2024-01-09T08:52:15.922198057Z","timestamp":2567269914,"rssi":-125,"channel_rssi":-125,"snr":-7.5,"location":{"latitude":46.209518405319514,"longitude":6.135730147361756,"source":"SOURCE_REGISTRY"},"uplink_token":"ChwKGgoOaGVwaWEtbGVjZWEtMDESCAAWwAH/ENr2EJrclcgJGgwIwZL0rAYQ5MnBigEgkKvY6dvi7wI=","received_at":"2024-01-09T08:52:17.270966836Z"},{"gateway_ids":{"gateway_id":"eui-00016c001f160f18","eui":"00016C001F160F18"},"time":"2024-01-09T09:12:24.226Z","timestamp":3736065597,"rssi":-60,"channel_rssi":-60,"snr":14.5,"frequency_offset":"-630","location":{"latitude":46.46313,"longitude":6.23425,"altitude":726,"source":"SOURCE_REGISTRY"},"uplink_token":"CiIKIAoUZXVpLTAwMDE2YzAwMWYxNjBmMTgSCAABbAAfFg8YEL2sv/UNGgwIwZL0rAYQmNG6jAEgyLzz9t2DIyoLCPib9KwGEID54Ws=","channel_index":6,"gps_time":"2024-01-09T09:12:24.226Z","received_at":"2024-01-09T08:52:17.294561944Z"}],"settings":{"data_rate":{"lora":{"bandwidth":125000,"spreading_factor":7,"coding_rate":"4/5"}},"frequency":"867700000","timestamp":2567269914,"time":"2024-01-09T08:52:15.922198057Z"},"received_at":"2024-01-09T08:52:17.291144008Z","consumed_airtime":"0.061696s","locations":{"user":{"latitude":46.4631023,"longitude":6.23158,"altitude":753,"source":"SOURCE_REGISTRY"}},"network_ids":{"net_id":"000013","ns_id":"EC656E0000000181","tenant_id":"ttn","cluster_id":"eu1","cluster_address":"eu1.cloud.thethings.network"}}}' 
#echo $data | jq
curl --silent -H 'Content-type: application/json' --data $data https://odoo.nella.org/ttn/uplink

# For debugging position reports
#curl --silent -H 'Content-type: application/json' --data '{"end_device_ids":{"device_id":"jeff-tracker","application_ids":{"application_id":"wheres-sharan"},"dev_eui":"A84041B071880593","join_eui":"A840410000000102","dev_addr":"260BB5F6"},"correlation_ids":["gs:uplink:01HKPMRD3A4EED2HJWGPQ1F1AM"],"received_at":"2024-01-09T08:17:23.771757420Z","uplink_message":{"session_key_id":"AYzp39GJSBfZXju1goYmYg==","f_port":2,"f_cnt":43,"frm_payload":"AsfK9ABhylEOIyAB8wCg","decoded_payload":{"ALARM_status":"FALSE","Hum":49.9,"LON":"ON","Latitude":46.648052,"Location":"46.648052,6.408785","Longitud":6.408785,"MD":0,"Tem":16,"Transport":"STILL"},"rx_metadata":[{"gateway_ids":{"gateway_id":"eui-a84041ffff269190","eui":"A84041FFFF269190"},"time":"2024-01-09T08:17:23.519348Z","timestamp":2940349980,"rssi":-74,"channel_rssi":-74,"snr":13.5,"frequency_offset":"-2877","uplink_token":"CiIKIAoUZXVpLWE4NDA0MWZmZmYyNjkxOTASCKhAQf//JpGQEJzciPoKGgwIk4L0rAYQ4+2JjAIg4LqQ1MmrDg==","channel_index":7,"received_at":"2024-01-09T08:17:23.562198243Z"}],"settings":{"data_rate":{"lora":{"bandwidth":125000,"spreading_factor":7,"coding_rate":"4/5"}},"frequency":"867900000","timestamp":2940349980,"time":"2024-01-09T08:17:23.519348Z"},"received_at":"2024-01-09T08:17:23.563605225Z","consumed_airtime":"0.066816s","version_ids":{"brand_id":"dragino","model_id":"lbt1","hardware_version":"_unknown_hw_version_","firmware_version":"1.2","band_id":"EU_863_870"},"network_ids":{"net_id":"000013","ns_id":"EC656E0000000181","tenant_id":"ttn","cluster_id":"eu1","cluster_address":"eu1.cloud.thethings.network"}}}' \
#    https://odoo.nella.org/ttn/uplink | jq
