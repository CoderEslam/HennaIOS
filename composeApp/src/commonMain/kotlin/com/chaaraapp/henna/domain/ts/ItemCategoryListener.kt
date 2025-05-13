package com.chaaraapp.henna.domain.ts

import com.chaaraapp.henna.domain.model.categories.CategoryModel
import kotlinx.coroutines.Job


interface ItemCategoryListener {
    fun itemCategory(categoryModel: CategoryModel) : Job
}