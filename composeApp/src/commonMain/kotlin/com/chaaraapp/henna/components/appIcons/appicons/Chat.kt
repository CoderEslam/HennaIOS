package com.chaaraapp.henna.components.appIcons.appicons

import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.PathFillType.Companion.NonZero
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.StrokeCap.Companion.Round
import androidx.compose.ui.graphics.StrokeJoin
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.graphics.vector.ImageVector.Builder
import androidx.compose.ui.graphics.vector.path
import androidx.compose.ui.unit.dp
import com.chaaraapp.henna.components.appIcons.AppIcons

public val AppIcons.Chat: ImageVector
    get() {
        if (_chat != null) {
            return _chat!!
        }
        _chat = Builder(name = "Chat", defaultWidth = 20.0.dp, defaultHeight = 20.0.dp,
                viewportWidth = 20.0f, viewportHeight = 20.0f).apply {
            path(fill = SolidColor(Color(0x00000000)), stroke = SolidColor(Color(0xFF457673)),
                    strokeLineWidth = 1.05469f, strokeLineCap = Round, strokeLineJoin =
                    StrokeJoin.Companion.Round, strokeLineMiter = 4.0f, pathFillType = NonZero) {
                moveTo(11.2429f, 1.0573f)
                curveTo(10.8701f, 1.0195f, 10.4902f, 1.0f, 10.1048f, 1.0f)
                curveTo(5.0764f, 1.0f, 1.0f, 4.3184f, 1.0f, 8.4118f)
                curveTo(1.0f, 12.5052f, 5.0764f, 15.8236f, 10.1048f, 15.8236f)
                curveTo(10.8908f, 15.8236f, 11.6535f, 15.7425f, 12.381f, 15.5901f)
                lineTo(15.7953f, 19.0001f)
                verticalLineTo(14.2354f)
                curveTo(17.3281f, 13.1989f, 18.5599f, 11.6414f, 19.0001f, 10.0f)
                moveTo(19.0001f, 4.9375f)
                curveTo(19.0001f, 6.4908f, 17.7409f, 7.75f, 16.1876f, 7.75f)
                curveTo(14.6343f, 7.75f, 13.3751f, 6.4908f, 13.3751f, 4.9375f)
                curveTo(13.3751f, 3.3842f, 14.6343f, 2.125f, 16.1876f, 2.125f)
                curveTo(17.7409f, 2.125f, 19.0001f, 3.3842f, 19.0001f, 4.9375f)
                close()
            }
        }
        .build()
        return _chat!!
    }

private var _chat: ImageVector? = null
