from django.contrib import admin

from .models import Question, Choice

# Register your models here.
# admin.site.register([Question, Choice])


class ChoicesInline(admin.StackedInline):
    model = Choice
    can_delete = False
    verbose_name_plural = 'Choices'
    readonly_fields = ['votes']  # Campos de solo lectura


@admin.register(Question)
class QuestionAdmin(admin.ModelAdmin):
    inlines = (ChoicesInline, )
