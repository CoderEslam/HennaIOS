package com.chaaraapp.henna.components.appIcons.appicons

import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.PathFillType.Companion.NonZero
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.StrokeCap.Companion.Butt
import androidx.compose.ui.graphics.StrokeJoin.Companion.Miter
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.graphics.vector.ImageVector.Builder
import androidx.compose.ui.graphics.vector.path
import androidx.compose.ui.unit.dp
import com.chaaraapp.henna.components.appIcons.AppIcons

public val AppIcons.Game: ImageVector
    get() {
        if (_game != null) {
            return _game!!
        }
        _game = Builder(name = "Game", defaultWidth = 23.0.dp, defaultHeight = 17.0.dp,
                viewportWidth = 23.0f, viewportHeight = 17.0f).apply {
            path(fill = SolidColor(Color(0xFF457673)), stroke = null, strokeLineWidth = 0.0f,
                    strokeLineCap = Butt, strokeLineJoin = Miter, strokeLineMiter = 4.0f,
                    pathFillType = NonZero) {
                moveTo(16.1779f, 6.7209f)
                horizontalLineTo(13.8386f)
                curveTo(13.6835f, 6.7209f, 13.5348f, 6.6585f, 13.4251f, 6.5472f)
                curveTo(13.3154f, 6.436f, 13.2538f, 6.2852f, 13.2538f, 6.1279f)
                curveTo(13.2538f, 5.9706f, 13.3154f, 5.8198f, 13.4251f, 5.7086f)
                curveTo(13.5348f, 5.5974f, 13.6835f, 5.5349f, 13.8386f, 5.5349f)
                horizontalLineTo(16.1779f)
                curveTo(16.333f, 5.5349f, 16.4818f, 5.5974f, 16.5915f, 5.7086f)
                curveTo(16.7011f, 5.8198f, 16.7627f, 5.9706f, 16.7627f, 6.1279f)
                curveTo(16.7627f, 6.2852f, 16.7011f, 6.436f, 16.5915f, 6.5472f)
                curveTo(16.4818f, 6.6585f, 16.333f, 6.7209f, 16.1779f, 6.7209f)
                close()
                moveTo(9.1601f, 5.5349f)
                horizontalLineTo(8.1853f)
                verticalLineTo(4.5465f)
                curveTo(8.1853f, 4.3892f, 8.1237f, 4.2384f, 8.014f, 4.1272f)
                curveTo(7.9044f, 4.016f, 7.7556f, 3.9535f, 7.6005f, 3.9535f)
                curveTo(7.4454f, 3.9535f, 7.2967f, 4.016f, 7.187f, 4.1272f)
                curveTo(7.0773f, 4.2384f, 7.0157f, 4.3892f, 7.0157f, 4.5465f)
                verticalLineTo(5.5349f)
                horizontalLineTo(6.041f)
                curveTo(5.8859f, 5.5349f, 5.7371f, 5.5974f, 5.6275f, 5.7086f)
                curveTo(5.5178f, 5.8198f, 5.4562f, 5.9706f, 5.4562f, 6.1279f)
                curveTo(5.4562f, 6.2852f, 5.5178f, 6.436f, 5.6275f, 6.5472f)
                curveTo(5.7371f, 6.6585f, 5.8859f, 6.7209f, 6.041f, 6.7209f)
                horizontalLineTo(7.0157f)
                verticalLineTo(7.7093f)
                curveTo(7.0157f, 7.8666f, 7.0773f, 8.0174f, 7.187f, 8.1286f)
                curveTo(7.2967f, 8.2399f, 7.4454f, 8.3023f, 7.6005f, 8.3023f)
                curveTo(7.7556f, 8.3023f, 7.9044f, 8.2399f, 8.014f, 8.1286f)
                curveTo(8.1237f, 8.0174f, 8.1853f, 7.8666f, 8.1853f, 7.7093f)
                verticalLineTo(6.7209f)
                horizontalLineTo(9.1601f)
                curveTo(9.3152f, 6.7209f, 9.4639f, 6.6585f, 9.5736f, 6.5472f)
                curveTo(9.6833f, 6.436f, 9.7449f, 6.2852f, 9.7449f, 6.1279f)
                curveTo(9.7449f, 5.9706f, 9.6833f, 5.8198f, 9.5736f, 5.7086f)
                curveTo(9.4639f, 5.5974f, 9.3152f, 5.5349f, 9.1601f, 5.5349f)
                close()
                moveTo(22.4004f, 15.5669f)
                curveTo(22.095f, 16.0093f, 21.6889f, 16.3705f, 21.2165f, 16.62f)
                curveTo(20.7442f, 16.8694f, 20.2195f, 16.9998f, 19.6869f, 17.0f)
                curveTo(18.8097f, 16.9979f, 17.9689f, 16.6445f, 17.3476f, 16.0166f)
                lineTo(17.3222f, 15.9889f)
                lineTo(13.3883f, 11.4651f)
                horizontalLineTo(9.6104f)
                lineTo(5.6813f, 15.9879f)
                lineTo(5.6511f, 16.0116f)
                curveTo(5.0313f, 16.6423f, 4.1899f, 16.9978f, 3.3118f, 17.0f)
                curveTo(2.828f, 16.9997f, 2.3502f, 16.8919f, 1.9118f, 16.6844f)
                curveTo(1.4735f, 16.4768f, 1.0853f, 16.1745f, 0.7744f, 15.7985f)
                curveTo(0.4636f, 15.4226f, 0.2377f, 14.9822f, 0.1127f, 14.5083f)
                curveTo(-0.0124f, 14.0344f, -0.0336f, 13.5385f, 0.0504f, 13.0554f)
                curveTo(0.0504f, 13.0554f, 0.0504f, 13.0495f, 0.0504f, 13.0455f)
                lineTo(1.6451f, 4.7323f)
                curveTo(1.8745f, 3.4072f, 2.5571f, 2.2064f, 3.573f, 1.3409f)
                curveTo(4.5889f, 0.4754f, 5.8731f, 7.0E-4f, 7.1999f, 0.0f)
                horizontalLineTo(15.788f)
                curveTo(17.1115f, 0.0017f, 18.3924f, 0.4736f, 19.4083f, 1.3336f)
                curveTo(20.4242f, 2.1937f, 21.1108f, 3.3875f, 21.3487f, 4.7076f)
                curveTo(21.3487f, 4.7145f, 21.3487f, 4.7195f, 21.3487f, 4.7264f)
                lineTo(22.9482f, 13.0465f)
                curveTo(22.9482f, 13.0465f, 22.9482f, 13.0534f, 22.9482f, 13.0574f)
                curveTo(23.0251f, 13.4916f, 23.0163f, 13.937f, 22.9223f, 14.3678f)
                curveTo(22.8282f, 14.7985f, 22.6509f, 15.2061f, 22.4004f, 15.5669f)
                close()
                moveTo(15.788f, 10.2791f)
                curveTo(16.9772f, 10.2791f, 18.1176f, 9.8001f, 18.9585f, 8.9474f)
                curveTo(19.7993f, 8.0948f, 20.2717f, 6.9384f, 20.2717f, 5.7326f)
                curveTo(20.2717f, 4.5268f, 19.7993f, 3.3703f, 18.9585f, 2.5177f)
                curveTo(18.1176f, 1.6651f, 16.9772f, 1.1861f, 15.788f, 1.1861f)
                horizontalLineTo(7.1999f)
                curveTo(6.1475f, 1.1869f, 5.129f, 1.5639f, 4.3236f, 2.2508f)
                curveTo(3.5182f, 2.9377f, 2.9773f, 3.8906f, 2.7962f, 4.9419f)
                curveTo(2.7957f, 4.9451f, 2.7957f, 4.9485f, 2.7962f, 4.9517f)
                lineTo(1.1996f, 13.2669f)
                curveTo(1.1217f, 13.7207f, 1.1879f, 14.1879f, 1.3886f, 14.601f)
                curveTo(1.5894f, 15.0142f, 1.9144f, 15.3521f, 2.3167f, 15.5659f)
                curveTo(2.7191f, 15.7797f, 3.178f, 15.8585f, 3.6273f, 15.7908f)
                curveTo(4.0766f, 15.7231f, 4.4931f, 15.5125f, 4.8168f, 15.1893f)
                lineTo(8.9105f, 10.4797f)
                curveTo(8.9657f, 10.4172f, 9.0333f, 10.3672f, 9.1089f, 10.3331f)
                curveTo(9.1845f, 10.2991f, 9.2664f, 10.2816f, 9.3491f, 10.282f)
                lineTo(15.788f, 10.2791f)
                close()
                moveTo(21.799f, 13.2669f)
                lineTo(20.8448f, 8.2905f)
                curveTo(20.3755f, 9.2434f, 19.6539f, 10.045f, 18.7609f, 10.6057f)
                curveTo(17.8678f, 11.1664f, 16.8384f, 11.464f, 15.788f, 11.4651f)
                horizontalLineTo(14.9469f)
                lineTo(18.1819f, 15.1893f)
                curveTo(18.5056f, 15.5125f, 18.9221f, 15.7231f, 19.3714f, 15.7908f)
                curveTo(19.8207f, 15.8585f, 20.2796f, 15.7797f, 20.6819f, 15.5659f)
                curveTo(21.0843f, 15.3521f, 21.4093f, 15.0142f, 21.61f, 14.601f)
                curveTo(21.8108f, 14.1879f, 21.877f, 13.7207f, 21.799f, 13.2669f)
                close()
            }
        }
        .build()
        return _game!!
    }

private var _game: ImageVector? = null
