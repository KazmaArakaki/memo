``` kotlin
package app.arakaki.glsurfaceviewsample

import android.content.Context
import android.opengl.GLSurfaceView
import android.util.AttributeSet
import javax.microedition.khronos.egl.EGLConfig
import javax.microedition.khronos.opengles.GL10

class MyGLSurfaceView : GLSurfaceView {
    constructor(context: Context?) : super(context) {
        this.init()
    }

    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs) {
        this.init()
    }

    fun init() {
        this.setRenderer(MyRenderer())
    }

    class MyRenderer : GLSurfaceView.Renderer {
        override fun onDrawFrame(gl: GL10?) {
        }

        override fun onSurfaceCreated(gl: GL10?, config: EGLConfig?) {
        }

        override fun onSurfaceChanged(gl: GL10?, width: Int, height: Int) {
        }
    }
}
```
