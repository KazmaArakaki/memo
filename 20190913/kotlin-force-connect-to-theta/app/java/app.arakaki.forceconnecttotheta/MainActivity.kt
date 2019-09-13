package app.arakaki.forceconnecttotheta

import android.Manifest
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.net.wifi.ScanResult
import android.net.wifi.WifiManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    private final val PERMISSION_REQUEST_CODE: Int = 0

    private val thetaWifiSsidList: MutableList<String> = mutableListOf()
    private lateinit var listViewAdapter: ArrayAdapter<String>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        listViewAdapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, thetaWifiSsidList)

        listView.adapter = listViewAdapter

        listView.onItemClickListener = object : AdapterView.OnItemClickListener {
            override fun onItemClick(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                val thetaWifiSsid: String = thetaWifiSsidList[position]

                val intent: Intent = Intent(applicationContext, SubActivity::class.java)

                intent.putExtra("thetaWifiSsid", thetaWifiSsid)

                startActivity(intent)
            }
        }

        val permissionsAllGranted: Boolean = checkAndRequestPermissionsIfNeeded()

        if (permissionsAllGranted) {
            scanWifi()
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        val permissionsAllGranted: Boolean = checkAndRequestPermissionsIfNeeded()

        if (permissionsAllGranted) {
            scanWifi()
        }
    }

    private fun checkAndRequestPermissionsIfNeeded() : Boolean {
        var permissionsAllGranted: Boolean = true

        permissionsAllGranted = permissionsAllGranted && checkSelfPermission(Manifest.permission.ACCESS_NETWORK_STATE) == PackageManager.PERMISSION_GRANTED
        permissionsAllGranted = permissionsAllGranted && checkSelfPermission(Manifest.permission.ACCESS_WIFI_STATE) == PackageManager.PERMISSION_GRANTED
        permissionsAllGranted = permissionsAllGranted && checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED
        permissionsAllGranted = permissionsAllGranted && checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED
        permissionsAllGranted = permissionsAllGranted && checkSelfPermission(Manifest.permission.CHANGE_NETWORK_STATE) == PackageManager.PERMISSION_GRANTED
        permissionsAllGranted = permissionsAllGranted && checkSelfPermission(Manifest.permission.CHANGE_WIFI_STATE) == PackageManager.PERMISSION_GRANTED

        if (!permissionsAllGranted) {
            requestPermissions(arrayOf<String>(
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.ACCESS_WIFI_STATE,
                Manifest.permission.ACCESS_COARSE_LOCATION,
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.CHANGE_NETWORK_STATE,
                Manifest.permission.CHANGE_WIFI_STATE
            ), PERMISSION_REQUEST_CODE)
        }

        return permissionsAllGranted
    }

    private fun scanWifi() {
        val wifiManager: WifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager

        val wifiScanReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val success: Boolean = intent?.getBooleanExtra(WifiManager.EXTRA_RESULTS_UPDATED, false) ?: false

                val scanResults: List<ScanResult> = wifiManager.scanResults

                thetaWifiSsidList.clear()

                for (scanResult: ScanResult in scanResults) {
                    if (scanResult.SSID.take(5) == "THETA" && scanResult.SSID.takeLast(3) == "OSC") {
                        thetaWifiSsidList.add(scanResult.SSID)
                    }
                }

                listViewAdapter.notifyDataSetChanged()
            }
        }

        val intentFilter = IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION)

        registerReceiver(wifiScanReceiver, intentFilter)

        wifiManager.startScan()
    }
}
