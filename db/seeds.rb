# frozen_string_literal: true

Employee.create!([
                   { name: 'John Doe', title: 'Designer', email: 'john@redflag.ai', password: 'abc123',
                     work_focus: 'Design' },
                   { name: 'Jane Doe', title: 'Engineer', email: 'jane@redflag.ai', password: 'abc123',
                     work_focus: 'Development' }
                 ])

manager = Manager.create!(name: 'Peter Smith', title: 'Project Manager', email: 'peter@redflag.ai', password: 'abc123',
                          work_focus: 'Development')

project = Project.create!(title: 'Project 1', description: 'This is a project', manager_id: manager.id,
                          due_date: 1.month.from_now)

Task.create!([
               { title: 'Create login page', description: 'This is a task', creator_id: manager.id, assignee_id: User.last.id,
                 project_id: project.id, due_date: 1.month.from_now, status: 'not started', work_focus: 'Development' },
               { title: 'Design password reset workflow', description: 'This is a task', creator_id: manager.id,
                 assignee_id: User.last.id, project_id: project.id, due_date: 1.month.from_now, status: 'not started', work_focus: 'Design' },
               { title: 'End-to-end testing', description: 'This is a task', creator_id: manager.id, assignee_id: User.first.id,
                 project_id: project.id, due_date: 1.month.from_now, status: 'not started', work_focus: 'Development' },
             ])
