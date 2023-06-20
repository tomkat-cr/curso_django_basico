from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from .models import Question, Choice


def index(request):
    latest_question_list = Question.objects.all()
    return render(request, "polls/index.html",
                  dict({"latest_question_list": latest_question_list}))
    # return HttpResponse("Estas en la pagina principal de Premios Platzi App")


def detail(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, "polls/detail.html", dict({"question": question}))
    # return HttpResponse(f"Estas viendo la pregunta número {question_id}")


def results(request, question_id):
    return HttpResponse(
        f"Estas viendo los resultados de la pregunta número {question_id}")


def vote(request, question_id):
    # Esta vista no tiene frontend
    question = get_object_or_404(Question, pk=question_id)
    try:
        selected_choice = question.choice_set.get(pk=request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        return render(request, "polls/detail.html", dict({
            "question": question,
            "error_message": "No elegiste una respuesta"
        }))
    else:
        selected_choice.votes += 1
        selected_choice.save()
        return HttpResponseRedirect(
            reverse("polls:results", args=(question.id,)),
        )
    # return HttpResponse(f"Estas votando a la pregunta número {question_id}")
