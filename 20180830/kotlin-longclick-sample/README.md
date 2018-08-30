``` kotlin
package app.arakaki.glsurfaceviewsample

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        this.view.setOnLongClickListener {
            Log.d("MainActivity", "long click")

            return@setOnLongClickListener true
        }
    }
}
```
