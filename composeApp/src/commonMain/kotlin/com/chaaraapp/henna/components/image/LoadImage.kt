package com.chaaraapp.henna.components.image

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.ImageBitmap
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import coil3.request.SuccessResult
import com.chaaraapp.henna.utils.Constants
import com.github.panpf.sketch.AsyncImage
import com.github.panpf.sketch.rememberAsyncImageState
import com.github.panpf.sketch.request.ComposableImageOptions
import com.skydoves.landscapist.ImageOptions
import com.skydoves.landscapist.coil3.CoilImage
import hennaapp.composeapp.generated.resources.Res
import hennaapp.composeapp.generated.resources.compose_multiplatform
import org.jetbrains.compose.resources.painterResource


//@Composable
//fun LoadImage(
//    modifier: Modifier = Modifier,
//    image: String
//) {
//
////    AsyncImage(
////        modifier = modifier,
////        uri = "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
////        state = rememberAsyncImageState(ComposableImageOptions {
////            crossfade()
////            // There is a lot more...
////        }),
////        contentDescription = "photo",
////        contentScale = ContentScale.FillBounds
////    )
//
//
////    AsyncImage(
////        modifier = Modifier.size(100.dp).clip(CircleShape),
////        uri = image,
////        state = rememberAsyncImageState(ComposableImageOptions {
////            crossfade()
////            // There is a lot more...
////        }),
////        contentDescription = "photo",
////        contentScale = ContentScale.FillBounds
////    )
//
//    CoilImage(
//        modifier = modifier,
//        imageModel = {
//            image
//        },
//        imageOptions = ImageOptions(
//            contentScale = ContentScale.FillBounds,
//            alignment = Alignment.Center
//        ),
//        previewPlaceholder = painterResource(Res.drawable.compose_multiplatform),
//        failure = {
//            ErrorScreen(message = "Error")
//        },
//        loading = {
//            LoadingScreen()
//        },
//        success = { imageState, painter ->
//            imageState.imageBitmap?.let {
//                Image(
//                    bitmap = it,
//                    contentDescription = null,
//                    modifier = Modifier.fillMaxWidth().clip(
//                        RoundedCornerShape(24.dp)
//                    ),
//                    contentScale = ContentScale.FillBounds
//                )
//            }
//        }
//    )
//}

@Composable
fun LoadImage(
    modifier: Modifier = Modifier,
    image: String,
) {
    CoilImage(
        modifier = modifier,
        imageModel = {
            image
        },
        imageOptions = ImageOptions(
            contentScale = ContentScale.FillBounds,
            alignment = Alignment.Center
        ),
        previewPlaceholder = painterResource(Res.drawable.compose_multiplatform),
        failure = {
            ErrorScreen()
        },
        loading = {
            LoadingScreen()
        },
    )
}

@Composable
fun LoadImage(
    imageUrl: String,
    modifier: Modifier = Modifier,
    onImageLoaded: (ImageBitmap) -> Unit = {}
) {
    CoilImage(
        modifier = modifier,
        imageModel = {
            imageUrl
        },
        imageOptions = ImageOptions(
            contentScale = ContentScale.FillBounds,
            alignment = Alignment.Center
        ),
        previewPlaceholder = painterResource(Res.drawable.compose_multiplatform),
        failure = {
            ErrorScreen(message = "Error")
        },
        loading = {
            LoadingScreen()
        },
        success = { imageState, painter ->
            imageState.imageBitmap?.let {
                onImageLoaded(it)
            }

        }
    )
}