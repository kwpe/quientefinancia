# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160107003710) do

  create_table "aportes", force: :cascade do |t|
    t.date     "fecha"
    t.string   "proceso_electoral"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.string   "nombre"
    t.string   "tipo_doc"
    t.string   "nro_doc"
    t.string   "tipo"
    t.string   "naturaleza"
    t.decimal  "importe"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "aportes_periodo", force: :cascade do |t|
    t.string   "nombre"
    t.string   "tipo_doc"
    t.string   "nro_doc"
    t.decimal  "importe",    precision: 12, scale: 2
    t.integer  "periodo_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "periodos", force: :cascade do |t|
    t.string   "descripcion"
    t.decimal  "aporte_efectivo"
    t.decimal  "aporte_especies"
    t.decimal  "total"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
