package com.chaaraapp.henna.components.arc

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.input.pointer.pointerInput
import kotlin.math.PI
import kotlin.math.atan2
import kotlin.math.min


@Composable
fun HalfCircleProgressSeekBar(
    progress: Float, // Current progress (0.0 to 1.0)
    onProgressChanged: (Float) -> Unit,
    modifier: Modifier = Modifier,
    strokeWidth: Float = 16f,
    startAngle: Float = 180f, // Start angle for the half-circle arc
    sweepAngle: Float = 180f, // Sweep angle for the half-circle arc
    backgroundColor: Color = Color.Gray,
    progressColor: Color = Pink
) {
    var currentProgress by remember { mutableStateOf(progress) }

    Canvas(
        modifier = modifier
            .pointerInput(Unit) {
                detectDragGestures { change, _ ->
                    val center = Offset((size.width / 2).toFloat(), (size.height).toFloat())
                    val touchAngle = calculateTouchAngleForHalfCircle(
                        center,
                        change.position,
                        startAngle,
                        sweepAngle
                    )
                    if (touchAngle != null) {
                        currentProgress = touchAngle / sweepAngle
                        onProgressChanged(currentProgress)
                    }
                }
            }
    ) {
        val width = 700f
        val height = 700f
        val radius = min(width, height) / 2 - strokeWidth

        // Draw background arc
        drawArc(
            color = backgroundColor,
            startAngle = startAngle,
            sweepAngle = sweepAngle,
            useCenter = false,
            size = Rect(
                left = strokeWidth,
                top = height / 2 - radius,
                right = width - strokeWidth,
                bottom = height / 2 + radius
            ).size,
            style = Stroke(strokeWidth, cap = StrokeCap.Round)
        )

        // Draw progress arc
        drawArc(
            color = progressColor,
            startAngle = startAngle,
            sweepAngle = sweepAngle * currentProgress,
            useCenter = false,
            size = Rect(
                left = strokeWidth,
                top = height / 2 - radius,
                right = width - strokeWidth,
                bottom = height / 2 + radius
            ).size,
            style = Stroke(strokeWidth, cap = StrokeCap.Round)
        )
    }
}

// Helper function to calculate angle from touch input for half-circle
fun calculateTouchAngleForHalfCircle(
    center: Offset,
    touchPoint: Offset,
    startAngle: Float,
    sweepAngle: Float
): Float? {
    val dx = touchPoint.x - center.x
    val dy = center.y - touchPoint.y // Reverse y-axis to match Cartesian coordinate system
    val angle = toDegrees(atan2(dy.toDouble(), dx.toDouble())).toFloat() + 180 // Normalize to [0, 360]
    val adjustedAngle = (angle - startAngle + 360) % 360
    return if (adjustedAngle in 0f..sweepAngle) adjustedAngle else null
}

fun toDegrees(radians: Double): Double {
    return radians * (180.0 / PI)
}


val Pink= Color(0xFFE35C8B)