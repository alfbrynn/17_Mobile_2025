import '../models/data_layer.dart';
import 'package:flutter/material.dart';
import '../plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          // Pastikan plan yang ditampilkan selalu versi terbaru
          final currentPlan = plans.firstWhere(
            (p) => p.name == widget.plan.name,
            orElse: () => widget.plan,
          );

          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final plans = List<Plan>.from(planNotifier.value);
        final planIndex = plans.indexWhere((p) => p.name == widget.plan.name);

        if (planIndex == -1) return; // jika plan belum terdaftar

        // Buat list baru untuk tasks
        final updatedTasks = List<Task>.from(plans[planIndex].tasks)
          ..add(const Task(description: '', complete: false));

        // Update plan spesifik
        plans[planIndex] = Plan(
          name: plans[planIndex].name,
          tasks: updatedTasks,
        );

        // Trigger ValueNotifier agar rebuild otomatis
        planNotifier.value = plans;
      },
    );
  }

  Widget _buildList(Plan plan) {
    if (plan.tasks.isEmpty) {
      return const Center(
        child: Text('Belum ada task. Tekan + untuk menambah tugas.'),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(plan, plan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Plan plan, Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final plans = List<Plan>.from(planNotifier.value);
          final planIndex = plans.indexWhere((p) => p.name == plan.name);
          if (planIndex == -1) return;

          final updatedTasks = List<Task>.from(plan.tasks);
          updatedTasks[index] = Task(
            description: task.description,
            complete: selected ?? false,
          );

          plans[planIndex] = Plan(name: plan.name, tasks: updatedTasks);

          planNotifier.value = plans;
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          final plans = List<Plan>.from(planNotifier.value);
          final planIndex = plans.indexWhere((p) => p.name == plan.name);
          if (planIndex == -1) return;

          final updatedTasks = List<Task>.from(plan.tasks);
          updatedTasks[index] = Task(
            description: text,
            complete: task.complete,
          );

          plans[planIndex] = Plan(name: plan.name, tasks: updatedTasks);

          planNotifier.value = plans;
        },
      ),
    );
  }
}
