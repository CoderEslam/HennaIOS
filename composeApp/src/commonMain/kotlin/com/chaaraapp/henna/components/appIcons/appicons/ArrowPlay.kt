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

public val AppIcons.ArrowPlay: ImageVector
    get() {
        if (_ArrowPlay != null) {
            return _ArrowPlay!!
        }
        _ArrowPlay = Builder(
            name = "Polygon 1", defaultWidth = 30.0.dp, defaultHeight = 26.0.dp,
            viewportWidth = 30.0f, viewportHeight = 26.0f
        ).apply {
            path(
                fill = SolidColor(Color(0xFFAD1D4C)), stroke = null, strokeLineWidth = 0.0f,
                strokeLineCap = Butt, strokeLineJoin = Miter, strokeLineMiter = 4.0f,
                pathFillType = NonZero
            ) {
                moveTo(11.5359f, 2.0f)
                curveTo(13.0755f, -0.6667f, 16.9245f, -0.6667f, 18.4641f, 2.0f)
                lineTo(28.8564f, 20.0f)
                curveTo(30.396f, 22.6667f, 28.4715f, 26.0f, 25.3923f, 26.0f)
                horizontalLineTo(4.6077f)
                curveTo(1.5285f, 26.0f, -0.396f, 22.6667f, 1.1436f, 20.0f)
                lineTo(11.5359f, 2.0f)
                close()
            }
        }
            .build()
        return _ArrowPlay!!
    }

private var _ArrowPlay: ImageVector? = null
