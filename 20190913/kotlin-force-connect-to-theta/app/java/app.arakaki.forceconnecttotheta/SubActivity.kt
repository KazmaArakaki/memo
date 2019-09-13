package app.arakaki.forceconnecttotheta

import android.content.Context
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_sub.*

class SubActivity : AppCompatActivity() {
    var thetaWifiSsid: String = ""
    var thetaWifiPassword: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_sub)

        thetaWifiSsid = intent.getStringExtra("thetaWifiSsid")
        thetaWifiPassword = Regex("\\d+").find(thetaWifiSsid)?.value ?: ""

        thetaWifiSsidLabel.text = thetaWifiSsid
        thetaWifiPasswordField.setText(thetaWifiPassword)

        submitButton.setOnClickListener {
            val wifiManager: WifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager

            val wifiConfiguration: WifiConfiguration = WifiConfiguration()

            wifiConfiguration.SSID = "\"${thetaWifiSsid}\""
            wifiConfiguration.hiddenSSID = true
            wifiConfiguration.allowedKeyManagement.set(WifiConfiguration.KeyMgmt.WPA_PSK)
            wifiConfiguration.preSharedKey = "\"${thetaWifiPassword}\""
            wifiConfiguration.status = WifiConfiguration.Status.ENABLED

            val networkId: Int = wifiManager.addNetwork(wifiConfiguration)

            if (networkId != -1) {
                wifiManager.disconnect()
                wifiManager.enableNetwork(networkId, true)
                wifiManager.reconnect()
            }
        }
    }
}
